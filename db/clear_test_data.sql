delete from ratings;
delete from users where id not in (1,2,14);
delete from permissions;
update services set description = null, elevator_pitch = null, cached_rating = null, no_comments = null, invite_comment_up_to_stars = null, users_need_approval = null, disable_rating_appeal = null;