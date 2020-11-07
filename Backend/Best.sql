create database Best;

use Best;


create table Users(
	id_u varchar(36) primary key unique,
    id varchar(20),
    pass varchar(20),
    username varchar(30));
        
create table Docs(
	id_d varchar(36) primary key unique,
    id_u varchar(36),
    type varchar(10));

create  table Doc_Storage(
    id_doc varchar(36) primary key,
    doc_details CHAR(50),
    doc_DATA LONGBLOB,
    doc_NAME CHAR(50),
    doc_SIZE CHAR(50),
    id_d varchar(36));    


alter table Doc_Storage
add constraint FK_doc
foreign key (id_d) references Docs(id_d);

alter table Docs
add constraint FK_id_u
foreign key (id_u) references Users(id_u);

#add user
DELIMITER //
create procedure Add_User(IN id_ varchar(20), username_ varchar(30), pass_ varchar(20))
begin
	insert into Users(id_u, id, pass, username) values (UUID(), id_, pass_, username_);
end//

DELIMITER ;

#add doc
DELIMITER //
create procedure Add_Doc(IN id_ varchar(20), type_ varchar(10), doc_details_ CHAR(50), doc_DATA_ LONGBLOB,
    doc_NAME_ CHAR(50), doc_SIZE_ int)
begin
	declare id_u_ varchar(36);
	declare id_d_ varchar(36);
        
    set id_u_ = (select id_u from Users where Users.id like id_);
    set id_d_ = (Select UUID());
	insert into Docs(id_d, id_u, type) values (id_d_, id_u_, type_);
    
    insert into Doc_Storage(id_doc, doc_details, doc_data, doc_name, doc_size, id_d) 
    values ((Select UUID()), doc_details_, doc_data_, doc_name_, doc_size_, id_d_);
    
end//

DELIMITER ;

#get users
DELIMITER //
create procedure Get_Users()
begin
	select * from Users;
end//

DELIMITER ;

#get docs
DELIMITER //
create procedure Get_Docs()
begin
	select * from Docs_Storage;
end//

DELIMITER ;

#get username
DELIMITER //
create procedure Get_Username(email varchar(30))
begin
	select username from Users
    where Users.id like email;
end//

DELIMITER ;

#change password
DELIMITER //
create procedure Change_Password(email varchar(30), new_pass varchar(20))
begin
	declare id varchar(36);
    set id = (select id_u From Users where Users.id like email);
    
	update Users
    set pass = new_pass
    where id_u like id;
end//

DELIMITER ;


CALL Add_Doc("Cazamir", "png", "poza de test", 
		x'89504E470D0A1A0A0000000D494844520000001000000010080200000090916836000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000001E49444154384F6350DAE843126220493550F1A80662426C349406472801006AC91F1040F796BD0000000049454E44AE426082',
		'Test', 100);
        
select * from Users;

select * from Doc_Storage;

CALL Add_User('Cazamir@gmail.com','CAzamir', 'sdfgrew');

call Get_Username('Cazamir@gmail.com');

call Change_Password('Cazamir@gmail.com', 'kkjhdffghj');

