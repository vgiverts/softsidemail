DROP TABLE email_templates;
DROP TABLE list_members;
DROP TABLE sent_emails;
DROP TABLE email_actions;

DROP TABLE cookies;
DROP TABLE tracking_hits;

CREATE TABLE email_templates (
  id      BIGINT PRIMARY KEY,
  subject VARCHAR(256)                        NOT NULL,
  body    TEXT                                NOT NULL,
  created TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE list_members (
  id            INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  first_name    VARCHAR(128)                        NOT NULL,
  last_name     VARCHAR(128),
  company       VARCHAR(128),
  position      VARCHAR(128),
  created       TIMESTAMP DEFAULT current_timestamp NOT NULL,
  email         VARCHAR(128)                        NOT NULL,
  personal_role INT REFERENCES personal_roles (id)
);

SELECT *
FROM list_members;

CREATE TABLE sent_emails (
  id                INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  email_template_id BIGINT REFERENCES email_templates (id),
  list_member_id    INT REFERENCES list_members (id),
  third_party_id    CHAR(64),
  created           TIMESTAMP DEFAULT current_timestamp NOT NULL
);
CREATE INDEX sent_email__third_party_id
  ON sent_emails (third_party_id);

CREATE TABLE email_actions (
  id            INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  sent_email_id INT REFERENCES sent_emails (id),
  action        CHAR(16) REFERENCES email_actions_enum (action) NOT NULL,
  created       TIMESTAMP DEFAULT current_timestamp             NOT NULL
);

CREATE TABLE links (
  id      INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  url     VARCHAR(1024)                       NOT NULL,
  created TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE tracking_hits (
  id               INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  link_id          INT REFERENCES links (id)           NOT NULL,
  list_member_id   INT REFERENCES list_members (id),
  member_cookie_id INT REFERENCES member_cookies (id),
  ip_address       VARCHAR(128), --TODO: Change the IP Address type to something more appropriate
  referrer_url     VARCHAR(1024),
  created          TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE member_cookies (
  id             INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  list_member_id INT REFERENCES list_members (id),
  created        TIMESTAMP DEFAULT current_timestamp NOT NULL,
  updated        TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE email_actions_enum (
  action CHAR(16) PRIMARY KEY
);

CREATE TABLE personal_roles (
  id   INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  role VARCHAR(128) NOT NULL
);


insert into links (url) values ('');
select * from links;

INSERT INTO list_members (first_name, last_name, email) VALUES ('Mark', 'Johnson', 'vlad+3@cloudmars.com');

INSERT INTO email_actions_enum (action)
VALUES ('sent'), ('delivered'), ('opened'), ('clicked'), ('hard_bounce'), ('soft_bounce'), ('complaint');

SELECT * FROM email_actions_enum;

select * from member_cookies;
select * from tracking_hits;

INSERT INTO email_templates (subject, body) VALUES ('foo', 'bar'), ('asdf', 'qwer');