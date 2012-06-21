delete from ratings where service_id % 7 <> 4;

delete from service_regulator_scores where service_id % 7 <> 4;

delete from service_links where service_id % 7 <> 4;

delete from permissions where service_id % 7 <> 4;

delete from services where id % 7 <> 4;

delete from addresses where organisation_id in (
select id from
organisations ORG
where
not exists (select * from services where organisation_id = ORG.id) and
not exists (select * from regulators where organisation_id = ORG.id) and
not exists (
select * from
services S inner join
organisations ORG2 on ORG2.id = S.organisation_id inner join
ownerships OW on OW.organisation_id = ORG2.id where owning_organisation_id = ORG.id
));

delete from phones where organisation_id in (
select id from
organisations ORG
where
not exists (select * from services where organisation_id = ORG.id) and
not exists (select * from regulators where organisation_id = ORG.id) and
not exists (
select * from
services S inner join
organisations ORG2 on ORG2.id = S.organisation_id inner join
ownerships OW on OW.organisation_id = ORG2.id where owning_organisation_id = ORG.id
));

delete from ownerships where owning_organisation_id in (select id from
organisations ORG
where
not exists (select * from services where organisation_id = ORG.id) and
not exists (select * from regulators where organisation_id = ORG.id) and
not exists (
select * from
services S inner join
organisations ORG2 on ORG2.id = S.organisation_id inner join
ownerships OW on OW.organisation_id = ORG2.id where owning_organisation_id = ORG.id
)) or organisation_id in (select id from
organisations ORG
where
not exists (select * from services where organisation_id = ORG.id) and
not exists (select * from regulators where organisation_id = ORG.id) and
not exists (
select * from
services S inner join
organisations ORG2 on ORG2.id = S.organisation_id inner join
ownerships OW on OW.organisation_id = ORG2.id where owning_organisation_id = ORG.id
));

delete from organisations where id in (
select id from
organisations ORG
where
not exists (select * from services where organisation_id = ORG.id) and
not exists (select * from regulators where organisation_id = ORG.id) and
not exists (
select * from
services S inner join
organisations ORG2 on ORG2.id = S.organisation_id inner join
ownerships OW on OW.organisation_id = ORG2.id where owning_organisation_id = ORG.id
));