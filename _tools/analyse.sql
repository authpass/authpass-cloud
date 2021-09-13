-- ##### some interesting sql queries.

-- largest files by size
select f.id, left(f.name, 10), e.email_address, to_char(fc.length / 1024. / 1024., '990.999'), f.last_access_at
from filecloud_file f
         inner join filecloud_file_content fc on fc.id = f.last_content_id
         inner join user_email e on e.user_id = f.user_id
order by fc.length desc
limit 10;


-- most shared files
select f.id, left(f.name, 10), e.email_address, count(ft.token) tokens, f.last_access_at
from filecloud_file f
         inner join filecloud_token ft on ft.file_id = f.id
         inner join user_email e on e.user_id = f.user_id
group by f.id, e.email_address
order by tokens desc
limit 5;

