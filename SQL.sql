------------
Use Sample1  -----paneb kaima tabeli
Go    
------------kasutad ylevaolevat database ja mine
-------------

DROP DATABASE Sample4  
------antud juhul kustutame sample4 database-i, see on naide, mida tegelikult ei ole olemas

-------------
CREATE Table tblGender
(
ID int NOT NULL Primary Key,  
Gender nvarchar(50) NOT NULL
)
------------- Loodi tabel, kus Gender on primary key ja ei tohi kasutada NULL vaartust

ALTER TABLE tblPerson ADD CONSTRAINT tblPerson_GenderID_FK
Foreign key (GenderID) references tblGender(ID)
------------loob tblPerson Key-ga kausta tblPerson_GenderID_FK key. 
------------Nyyd peaks saama ainult tblGender-s olevaid vaartuseid kasutada
-------------


Select * from tblGender
Select * from tblPerson

Insert into tblPerson (ID, Name, Email, GenderId) 
Values (12, 'Johnny','j@r.com', NULL)
--------sisestan tblPerson alla uue nime koos emailiga

--------
ALTER TABLE tblPerson  -----muuda antud tabelit tblPerson
DROP CONSTRAINT DF_tblPerson_GenderId
------selle kaskluseg lopetame piirnangu, mis on tblPerson tabelis e nyyd saab ka GenderID olla ka 4 ja null
----------------
ALTER TABLE tblPerson  --------muuda tabelit tblPerson
ADD CONSTRAINT DF_tblPerson_GenderId   -------lisa piirang
DEFAULT 3 FOR GENDERID   -------loime tblPersoni all on Constraints ja sinna tekkis DF_tblPerson_GenderId
--------
------

---------
DELETE FROM tblGender WHERE ID = 3
---------kustutan tblGender alt ID vaartuse 2, 1 jne; vastavalt oma soovile

INSERT INTO tblPerson
VALUES (13, 'Sara', 's@s.com', 2, -970)
-----------lisan andmeid tblPerson alla
----------- 6 video 2:30 min

-----------check constraint
-----------lahen tblPersoni alt Constraints folderisse ja tahan lisada new constraint
-----------ning kirjutan ([Age]>(0) AND [Age]<(150)), mis paneb piirangu peale ja ei luba vanust panna -970

DELETE FROM tblPerson WHERE ID = 7  ----kustutan tblPerson-i alt vastava ID kasutaja
INSERT INTO tblPerson VALUES (8, 'Sara', 's@s.com', 2, 100)

--------
ALTER TABLE tblPerson
DROP CONSTRAINT CK_tblPerson_Age  ------kustutan tblPersoni Constraint alt piirangu liigi
--------
--------
ALTER TABLE tblPerson
ADD CONSTRAINT CK_tblPerson_Age CHECK (AGE > 0 AND AGE < 150) -----sellega panen piirangu Constraintsi alla
--------

Select * from tblPerson

INSERT INTO dbo.tblPerson VALUES (9, 'Todd', 't@t.com', 1, 25)

--------kliki table peale ja vajuta new table ja sisesta uued andmed ning kliki column properitiesi peale
--------vaata increment ja seed ning pane enne specification yes peale ja nyyd hakkab automaatselt ID arvutama

Select * from dbo.tblPerson1

INSERT INTO dbo.tblPerson1 VALUES ('Martin')

DELETE FROM tblPerson1 WHERE PersonId = 6 ----kui kjustutan ara ja sisestan uue kasutaja, kelleks Todd,
----- siis vanat ID-d ei korrata, milleks oli John nr1.
----- kui ikka tahan ID 1 kasutada, siis pane nime ette 1, 'Jane'
----- enne tuleb aktiveerida IDENTITY_INSERT ja panna ON peale ning lisa VALUES ette sulgudesse
----- kui ei soovi konkreetselt sisestada PersonID ja Name, siis kustutad VALUES ees oleva ja pane OFF peale
SET IDENTITY_INSERT tblPerson1 OFF

-----kui soovin resetida ja kustutame koik tblPerson1
DELETE FROM dbo.tblPerson1
----- ja sisestan Martini andmebaasi, siis peab meeles ID arvestust ja milleks on antud juhul 6
------ alumise reaga saan panna ID  jalle 1 peale
DBCC CHECKIDENT (tblPerson1, RESEED, 0)

----------- uus ylesanne User1 session

CREATE TABLE Test1
(
ID int IDENTITY(1,1),
Value nvarchar(20)
)

CREATE TABLE Test2
(
ID int IDENTITY(1,1),
Value nvarchar(20)
)
----
INSERT INTO Test1 VALUES('X')
----
SELECT * FROM Test1
SELECT * FROM Test2


----Trigger
Create Trigger trForInsert ON Test1 for Insert
as
Begin
	Insert into Test2 Values ('YYYY')
End

----
SELECT SCOPE_IDENTITY ()
SELECT @@IDENTITY
----

----User1
INSERT INTO Test2 VALUES ('zzz')

SELECT SCOPE_IDENTITY ()  ----saab kasutada sama sessiooni ja sygavuse puhul
SELECT @@IDENTITY  ----saab kasutada sama sessiooni ja yle igasuguse sygavuse uurida
SELECT IDENT_CURRENT('Test2')  ----konkreetne tabel yle igasuguse sessiooni ja sygavuse
----------------

SELECT * FROM tblPerson

DELETE FROM tblPerson WHERE ID = 1


-----
ALTER TABLE tblPerson
ADD CONSTRAINT UQ_tblPerson_Email UNIQUE(Email) 
-----  sellega paneme paika, 
-----  et ainult yks kasutaja saab sellise emailiga olla. 
-----  Enne kustuta sama emailiga kasutajad ara.

INSERT INTO tblPerson VALUES (5, 'Sara','sara@abc.com', 2, 25, 'Mumbai')
----
---- Constrainti eemaldamine
ALTER TABLE tblPerson
DROP CONSTRAINT UQ_tblPerson_Email
----

----- Selekteerimine mingite omaduste jargi
-----
ALTER TABLE tblPerson
ADD City nvarchar(50);
----- lisan tabelisse uue i

SELECT * FROM tblPerson
---- otsin konkreetset linna columnist City
SELECT * FROM tblPerson WHERE City = 'London'
---- valistab koik, kes elavad all valja toodud kohas
SELECT * FROM tblPerson WHERE City <> 'London'
---- voib nurksulgude asemel kasutada  ka !=

SELECT * FROM tblPerson WHERE Age = 20 or Age = 23 or Age = 29 --- liiga pikk piirangute seadmine ja saab niimoodi
SELECT * FROM tblPerson WHERE Age IN (20, 23, 29) ---piirangute seadmine lyhemalt
SELECT * FROM tblPerson WHERE Age BETWEEN 20 AND 25 ----koik, kes on 20 kuni 25 a vanad
SELECT * FROM tblPerson WHERE City LIKE 'L%' ----koik linnad peaksid algama tahega L ja kaskluse annab %
SELECT * FROM tblPerson WHERE Email LIKE '%@%' ----ykstaspuha, kus asub antud juhul mark @ ja seda otsib
SELECT * FROM tblPerson WHERE Email NOT LIKE '%@%' ----ykstaspuha, kus ei asu antud juhul mark @ ja seda otsib
SELECT * FROM tblPerson WHERE Email LIKE '_@_.com' ----otsib, kus teine mark ei ole @
SELECT * FROM tblPerson WHERE Name LIKE '[MST]%' ----otsib nimesid, kus esimne mark algab M, S ja T-ga.
SELECT * FROM tblPerson WHERE Name LIKE '[^MST]%' ----otsib nimesid, kus esimne mark ei ole M, S ja T-ga.
SELECT * FROM tblPerson WHERE (City = 'London' or City = 'Mumbai') AND Age > 25 ----linn pab olema Mumbai voi London ja vanus korgem 25-st
SELECT * FROM tblPerson ORDER by Name ----selekteerib nime jargi
SELECT * FROM tblPerson ORDER by Name DESC  ----selekteerib langevas jarjestuses
SELECT TOP 3 * FROM tblPerson  ----votab 3 ylemist rida
SELECT TOP 2 Age, Name FROM  tblPerson  ----votab 2 nime ja vanuse ylemisest reast
SELECT TOP 50 PERCENT * FROM  tblPerson ----votab pooled nimekirjas olnutest
SELECT * FROM tblPerson Order by Age DESC  ----hakkab vanemast pihta ja langevas jarjekorras
SELECT TOP 1 * FROM tblPerson  Order by Age DESC  ----hakkab koige vanemast ja naitab ainult esimest

----------
----
SELECT DISTINCT Name, City FROM tblPerson
----- saan ainult selles tabelis oleva columni
use Sample1
SELECT * FROM tblEmployee
-------
CREATE TABLE tblEmployee  ----loome tabeli vastavate koolonitega
(
ID int NOT NULL Primary Key,
Name nvarchar(50) NOT NULL,  
Gender nvarchar(50) NOT NULL,
Salary int NULL,
City nvarchar(50)
)
-------
INSERT INTO tblEmployee VALUES (10, 'Russell','Male', 8800, 'London')
-------

SELECT SUM(Salary) FROM tblEmployee ----arvutab koikide palgad kokku
SELECT MIN(Salary) FROM tblEmployee ---- min palga saaja ja on olemas ka MAX
SELECT City, SUM(Salary) as TotalSalary FROM tblEmployee GROUP BY City ----nyyd naed linnade kaupa palga summat, mida arvutatakse kokku
SELECT City, Gender, SUM(Salary) as TotalSalary FROM tblEmployee GROUP BY City, Gender ----nyyd lisab soolise eristuse ka juurde
SELECT City, Gender, SUM(Salary) as TotalSalary FROM tblEmployee GROUP BY City, Gender ORDER BY City ---- sama nimega linnad on koos
SELECT Gender, City, SUM(Salary) as TotalSalary FROM tblEmployee GROUP BY City, Gender ORDER BY City ---- tahan enne sugu ja siis linna
SELECT COUNT(*) from tblEmployee ----loeb ara, mitu inimest on nimekirjas, * asemele voib panna ka muid columni nimetusi
SELECT Gender, City, SUM(Salary) as TotalSalary, COUNT (ID) as [Total Employee(s)] FROM tblEmployee GROUP BY Gender, City ----mitu tootajat on soo ja linna kaupa
SELECT Gender, City, SUM(Salary) as TotalSalary, COUNT (ID) as [Total Employee(s)] FROM tblEmployee WHERE Gender ='Male' GROUP BY Gender, City ----mitu tootajat on meessoost
SELECT Gender, City, SUM(Salary) as TotalSalary, COUNT (ID) as [Total Employee(s)] FROM tblEmployee GROUP BY Gender, City HAVING Gender ='Male' ----mitu tootajat on meessoost, kasutades HAVING
SELECT * FROM tblEmployee WHERE SUM(Salary) > 4000 ----niimoodi ei saa paringut teha

SELECT Gender, City, SUM(Salary) as TotalSalary, COUNT (ID) as [Total Employee(s)] FROM tblEmployee GROUP BY Gender, City HAVING SUM(Salary) > 5000


----------12 video juurde jain
SELECT * FROM tblEmployee

ALTER TABLE tblEmployee
DROP COLUMN City;

ALTER TABLE tblEmployee
ADD DepartmentId
int NULL;

SELECT * FROM tblEmployee  ----korras
SELECT * FROM tblDepartment   -----korras
SELECT * FROM tblGender    ----korras

INSERT INTO tblGender VALUES ('Valerie','Female', 5500, 'IT')

SELECT * FROM tblDepartment   -----korras

ALTER TABLE tblPerson DROP COLUMN Email
ALTER TABLE tblPerson ADD DepartmentHead nvarchar(50)

----- update-n andmeid
UPDATE tblPerson  
SET ID = 4, DepartmentName = 'Other Department', Location = 'Sydney', DepartmentHead = 'Cindrella'
WHERE ID = 4;

DELETE FROM tblDepartment WHERE ID = 5

SELECT * FROM tblEmployee  ----korras
SELECT * FROM tblDepartment   -----korras
SELECT * FROM tblGender


------JOIN TABLES Ylesanne 12
Select Name, Gender, Salary, DepartmentName
FROM tblEmployee 
INNER JOIN tblDepartment  ----soovitav oleks kasutada INNER JOIN kuna siis ytleb sinu kavatsusi erakordselt
ON tblEmployee.DepartmentId = tblDepartment.Id
----- peale selle tegemist on 

SELECT * FROM tblEmployee  ----korras
SELECT * FROM tblDepartment
----- kuidas saada k[ik andmed Empoyee-st Departmenti abelisse
Select Name, Gender, Salary, DepartmentName
FROM tblEmployee 
LEFT JOIN tblDepartment  ----v]id kasutada ka LEFT OUTER JOIN
ON tblEmployee.DepartmentId = tblDepartment.Id
-----

SELECT * FROM tblEmployee  ----korras
SELECT * FROM tblDepartment

-----kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
Select Name, Gender, Salary, DepartmentName
FROM tblEmployee 
RIGHT OUTER JOIN tblDepartment   
ON tblEmployee.DepartmentId = tblDepartment.Id

-----kuidas saada k]ikide tabelite omadused yhte tabelisse
Select Name, Gender, Salary, DepartmentName
FROM tblEmployee 
FULL OUTER JOIN tblDepartment  
ON tblEmployee.DepartmentId = tblDepartment.Id

-----Cross Join v[tab kaks allpool olevat tabelit kokku ja korrutab need omavahel igas osakonnas oleva tootajaga
Select Name, Gender, Salary, DepartmentName
FROM tblEmployee 
CROSS JOIN tblDepartment  
-----

SELECT   ColumnList
FROM     LeftTable
JoinType RightTable
ON       JoinCondition

Select Name, Gender, Salary, DepartmentName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblDepartment.Id = tblEmployee.DepartmentId

-----Ylesanne 13
-----kuidas kuvada ainult need isikud, kellel on DepartmentName NULL, siis tuleb JOIN-le lisada viimane rida
SELECT     Name, Gender, Salary, DepartmentName
FROM       tblEmployee
LEFT JOIN  tblDepartment
ON         tblEmployee.DepartmentId = tblDepartment.Id
WHERE      tblEmployee.DepartmentId IS NULL
-----teine viis teha
SELECT     Name, Gender, Salary, DepartmentName
FROM       tblEmployee
LEFT JOIN  tblDepartment
ON         tblEmployee.DepartmentId = tblDepartment.Id
WHERE      tblDepartment.Id IS NULL
-----saame teises tabelis oleva rea, kus on olemas NULL
SELECT     Name, Gender, Salary, DepartmentName
FROM       tblEmployee
RIGHT JOIN  tblDepartment
ON         tblEmployee.DepartmentId = tblDepartment.Id
WHERE      tblEmployee.DepartmentId IS NULL
-----FULL JOIN-i abil k]ikide tabelite mitte-katuvate omadustega read kuvab valja
SELECT     Name, Gender, Salary, DepartmentName
FROM       tblEmployee
FULL JOIN tblDepartment
ON         tblEmployee.DepartmentId = tblDepartment.Id
WHERE      tblEmployee.DepartmentId IS NULL  ---ara kunagi kasuta siin ja alumises reas = NULL
OR         tblDepartment.Id IS NULL

-----Ylesanne13
use Sample1
SELECT * FROM tblEmployee

ALTER TABLE tblEmployee
DROP COLUMN Gender, Salary;

DELETE FROM tblEmployee WHERE EmployeeID = 6

SELECT * FROM tblEmployee
SELECT * FROM tblDepartment

ALTER TABLE tblDeparmtent
DROP COLUMN Id;


INSERT INTO tblDepartment
VALUES ('Sam', 'Mike')

sp_rename 'tblDepartment.manager', 'Manager' ----sellega muudan columni nime 'tabelinimi.VanaNimi', 'UusNimi'

ALTER TABLE tblDepartment
DROP COLUMN Location;

SELECT * FROM tblEmployee

SELECT		E.Name as Employee, M.Name as Manager
FROM        tblEmployee E
LEFT JOIN   tblEmployee M  ----saab kahe tabeli kattuvad read j selle vahepeale jaavad ja mitte kattuvad sellest tabelist
ON			E.ManagerId = M.EmployeeID ----hetkel tahad n'ha ainult seda kahte columnit selles tabelis
-----kui kasutan INNER JOIN, siis kuvab neid, kus koik valjad taidetud e NULL-ga ei kuva
SELECT		E.Name as Employee, M.Name as Manager
FROM        tblEmployee E
INNER JOIN   tblEmployee M  
ON			E.ManagerId = M.EmployeeID
-----saame 5x5 rida nagu eelmine kord
SELECT		 E.Name as Employee, M.Name as Manager
FROM         tblEmployee E
CROSS JOIN   tblEmployee M

-----Ylesanne15
SELECT * FROM tblEmployee
SELECT * FROM tblDepartment


---esimene on null ja teeb ise loendamist, kui paneme NULL asemele midagi, 
---siis hakkab esimeses reas kuvama INGVAR
SELECT ISNULL('INGVAR', 'No Manager') as Manager

---COALESCE soovitav oleks meelde jatta kasklus COAL ESC E. See on sama, mis ISNULL kasklus
---kui panen NULL, siis kuvab esimesse ritta No Manager
SELECT COALESCE(NULL , 'No Manager') as Manager

---Kui EXPression on oige, siis paned vaartuse, mida soovid voi mone teise vaartuse, mida soovid (kasklus).
CASE WHEN EXPpression THEN '' ELSE '' END

----kui enne tegin SELECT tblEmployee, siis kuvas NULL, aga alumise kasklusega saab muuta NULL ara
SELECT        E.Name as Employee, ISNULL(M.Name, 'No Manager') as Manager
FROM          tblEmployee E
LEFT JOIN     tblEmployee M
ON			  E.ManagerId = M.EmployeeID

---CASE kaskluse kasutmine. Ylemise reaga kasin, et kui reas on NULL, siis tuleb No Manager sinna asmele.
SELECT        E.Name as Employee, CASE WHEN M.Name IS NULL THEN 'No Manager' ELSE M.Name END as Manager
FROM          tblEmployee E
LEFT JOIN     tblEmployee M
ON			  E.ManagerId = M.EmployeeID

---Ylesanne16
SELECT * FROM tblEmployee

---alguses muudame nimed columnites ara
sp_rename 'tblEmployee.EmployeeId', 'Id'

ALTER TABLE tblEmployee
ADD LastName nvarchar(50)

UPDATE tblEmployee  
SET Id = 5, FirstName = 'James', MiddleName = 'Nick' , LastName = 'Nancy'
WHERE ID = 5;

---kuidas kuvada tabel, et peale kasklust saada kuvada ainult need esimesed read, kus on olemas margid
---igast reast votab esimese taidetud lahtri ja kuvab ainult seda
SELECT * FROM tblEmployee

SELECT Id, COALESCE(FirstName, MiddleName, LastName) as Name
FROM   tblEmployee

---Ylesanne17
---loome uued tabelid korda
CREATE TABLE tblIndiaCustomers
(
ID int IDENTITY(1,1),
Value nvarchar(20)
)
sp_rename 'tblIndiaCustomers.Email', 'Name'
ALTER TABLE tblIndiaCustomers
ADD Email nvarchar(50)


CREATE TABLE tblUKCustomers
(
Id int IDENTITY(1,1),
Name nvarchar(20),
Email nvarchar(50)
)

Insert into tblUKCustomers (Name, Email) 
Values ('Sam','S@S.com')
---tabelid korras

---yhendan molemad tabelid ara, aga ubleerib molema tabeli andmeid
---siin jagab kahe tabeli vahel ara kogu koormuse
---UNION ALL on natuke kiirem vorreldes UNION-ga kuna ei pea eemaldama paringu ajal duplikaate
SELECT * FROM tblIndiaCustomers
UNION ALL
SELECT * FROM tblUKCustomers

---nyyd kastan ainult UNION ja ei dubleeri ning Id on ka jarjestatud
---see on natuke aeglasem kasklus kuna peab dublikaadid eemaldama
---vajuta Ctrl + L voi vajuta ylemisest reast Display Estimated Execution Plan
---aktiveeri alumine kasklus ja naed, et see votab 46% mahtu, proovi UNION ALL-ga
SELECT * FROM tblIndiaCustomers
UNION 
SELECT * FROM tblUKCustomers

---kui tahad kuvada, siis UNION-i puhul peab olema vordne arv columni nimesid ja veel oiges jarjestuses
---tuleb jargida ka erinevate ridade vaartused yhtiksid
SELECT Id, Email, Name FROM tblIndiaCustomers
UNION ALL
SELECT Id, Name, Email FROM tblUKCustomers

---kuidas tulemust sorteerida nime jargi
---ORDER BY kasutada ainult koige viimase reana
SELECT * FROM tblIndiaCustomers
UNION ALL
SELECT * FROM tblUKCustomers
ORDER BY Name 
---kui ORDER BY kasutada peale esimest Query-t, siis seda ei saa teha
--- nende vahel on, et UNION yhendab molemad tabelid omavahel yheks paringuks kasutades ridasid
--- JOIN saab andmeid kahest voi enamast tabelist ja lahtub loogikalisest suhtest kahe tabli vahel columnite yhendamisel


---Ylesanne 18; Stored Procedures
use Sample1

SELECT * FROM tblEmployee

ALTER TABLE tblEmployee
DROP COLUMN EmployeeID

sp_rename 'tblEmployee.ManagerId', 'Gender'

Insert into tblEmployee (Name, Gender)  Values ('Pam','Female')

---Monikord on ID ka mingi muu, kui nr kuna antud juhul on voti pandud Name peale
UPDATE tblEmployee  
SET Name = 'James', Gender = 'Male'
WHERE Name = 'James';
---tabel korras
---
SELECT * FROM tblEmployee

---peale kasklust mine storedProcedure peal ja tee refresh
---tuleb uus tabel
CREATE PROCEDURE spGetEmployees   ---sp tahendab storedProcedure e sailitatud kasklus
AS
BEGIN
	SELECT Name, Gender FROM tblEmployee
END

---sellega salvestasid kaskluse spGetEmployees
---nyyd saad selle sonaga anda seda kasklust, mitte ei pea kirjutama pikalt valja
---voib kasutada CREATE PROC
spGetEmployees
--- voib lyhendi ette panna ka EXEC voi EXECUTE
---voib ka manuaalselt seda kasklust anda e vajutada Object Exploreris olevale ja sealt edasi vajutada
EXEC spGetEmployees
---uuendan tabelit ja lisan juurde columneid
ALTER TABLE tblEmployee
ADD DepartmentId nvarchar(1)
---

--- Gender column peab olema vordne, mida iganes kasutaja sisestab peale @ marki
---
SELECT * FROM tblEmployee

CREATE PROC spGetEmployeesByGenderAndDepartment   
@Gender nvarchar (20),
@DepartmentId int
AS
BEGIN
	SELECT Name, Gender, DepartmentId FROM tblEmployee WHERE Gender = @Gender
	AND DepartmentId = @DepartmentId
END

---kui nyyd allolevat kasklust kaima panna, siis nouab Gender parameetrit
spGetEmployeesByGenderAndDepartment
---oige variant
spGetEmployeesByGenderAndDepartment 'Male', 1
---nyyd saan koik mehed ja vaartusega 1, kui alguses tegid sp kindla jarjekorra, 
---siis tuleb jargida ka edaspidi
---niimoodi saab mooda vaadata jarjekorrast
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

---aktiveeri allaolev kasklus ja siis kuvab teksti, mida kopeerid toolauale
---mitte kasutada sp kasklustes varianti sp_ kuna voib segadusse ajada lihtsalt sp-ga
sp_helptext spGetEmployees

CREATE PROCEDURE spGetEmployees   
AS  
BEGIN  
 SELECT Name, Gender FROM tblEmployee
END
--- seda ei saa enam kasutada kuna juba on olemas see kasklus
---kasklust muuta saab niimodi, et paned CREATE asemele ALTER
ALTER PROCEDURE spGetEmployees   
AS  
BEGIN  
 SELECT Name, Gender FROM tblEmployee  ORDER BY Name
END
---Protseduuri kustutamine
DROP PROC spGetEmployees
---
sp_helptext spGetEmployeesByGenderAndDepartment

---kuidas muuta teistmoodi sp ja panna voti peale, et keegi teine ei saaks muuta
ALTER PROC spGetEmployeesByGenderAndDepartment     
@Gender nvarchar (20),  
@DepartmentId int 
WITH Encryption 
AS  
BEGIN  
 SELECT Name, Gender, DepartmentId FROM tblEmployee WHERE Gender = @Gender  
 AND DepartmentId = @DepartmentId  
END

---Ylesanne19; sp koos output parametritega
use Sample1
SELECT * FROM tblEmployee
---teen protseduuri
CREATE PROCEDURE spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
AS
BEGIN
	SELECT @EmployeeCount = COUNT(Id) FROM tblEmployee WHERE Gender = @Gender
END
---
---kui OUTPUT seal ei ole, siis prindib valja NULL-i
---kui kasutan sona OUT, siis annab else taga oleva vastuse
---kindlasti peab kasutama parameetri nimetust, milleks on antud juhul Male
DECLARE @TotalCount int
Execute spGetEmployeeCountByGender 'Male', @TotalCount OUT
if(@TotalCount IS NULL)
	PRINT '@TotalCount is null'
else 
	PRINT '@TotalCount is not null'
PRINT @TotalCount
---
---saab ka teistmoodi paringut teha
DECLARE @TotalCount int
EXECUTE spGetEmployeeCountByGender @EmployeeCount = @TotalCount OUT, @Gender = 'Male'
PRINT @TotalCount

---selle abil naeb sp tapsemalt, sp_help-i saab kasutada
sp_help spGetEmployeeCountByGender
---saan koik info selle tabeli kohta, mille olen valinud
sp_help tblEmployee
---kui soovid sp tektsi naha
sp_helptext spGetEmployeeCountByGender

---saab naha, millest soltub see konkreetne sp ja siis saad teada, kas tabelit tasub kustutada
sp_depends spGetEmployeeCountByGender

sp_depends tblEmployee

---ylesanne20, stored procedure returnd values ja kuidas kasutada output values
SELECT * FROM tblEmployee

CREATE PROCEDURE spGetNameById
@Id int,
@Name nvarchar(20)  output
AS  
BEGIN  
 SELECT @Name = Id, @Name = Name FROM tblEmployee
END

---------
CREATE PROC spTotalCount1
@TotalCount int Out
AS
BEGIN
	SELECT @TotalCount = COUNT (Id) from tblEmployee
END
---see on sp ilma prameetrita

DECLARE @Total int
EXECUTE spTotalCount1 @Total OUT
PRINT @Total
---kui paneme return jargi oleva sulgudesse, siis see kasklus taidetakse esimesena
CREATE PROC spGetTotalCount2
AS
BEGIN
	RETURN (SELECT COUNT (Id) FROM tblEmployee) 
END
---arvutab kokku, kui palju Id-sid sul on
DECLARE @Total int
EXECUTE @Total = spGetTotalCount2
PRINT @Total
---vastavalt ID sisestamisele saab nime teada
CREATE PROC spGetNameById1
@Id int,
@Name nvarchar(20) OUTPUT
AS
BEGIN
	SELECT  @Name = Name FROM tblEmployee WHERE Id = @Id
END
---
SELECT * FROM tblEmployee
---kuvab kasutaja ID nr sisestamisel
DECLARE @Name nvarchar(20)
EXECUTE spGetNameById1 2,@Name OUT
PRINT 'Name = ' + @Name
---
CREATE PROC spGetNameById2
@Id int
AS
BEGIN
	RETURN (SELECT  Name FROM tblEmployee WHERE Id = @Id)
END
---sp vaartusega vastus tuleb alati int
DECLARE @Name nvarchar(20)
EXECUTE @Name = spGetNameById2 1
PRINT 'Name = ' + @Name
---return valued peaksid olema name, count jne

---ylesanne22 sp eelised, adHoc
SELECT * FROM tblEmployee
DELETE FROM tblEmployee WHERE ID = 4;

ALTER TABLE tblEmployee
DROP COLUMN DepartmentId
----tabel on korras
CREATE PROCEDURE spGetNameById
@Id int
AS
BEGIN
	SELECT Name FROM tblEmployee WHERE Id = @Id
END

EXECUTE spGetNameById 1
EXECUTE spGetNameById 2

SELECT Name FROM tblEmployee WHERE Id = 1
SELECT Name FROM tblEmployee WHERE Id = 2
---eelis on taitmise plaani taaskasutamine ja vahendab vorgu liiklust, koodi taaskasutamine, parem turvalisus
---ja valdib SQL sisendi rynnakud

---ylesanne22, string functions
SELECT * FROM tblEmployee

--see on varchar int ja saab tahe int katte
--see konverteerbi ASCII tahe vaartuse numbriks
SELECT ASCII ('a')
---prindib valja tahe A
SELECT CHAR (65)
--prindib kogu tahestiku valja
DECLARE @Start int
SET @Start = 67
WHILE (@Start <= 90)
BEGIN
	SELECT CHAR (@Start)
	SET @Start = @Start + 1
END
---saan vaiksed tahed valja prinditud, pean leidma margile vastava numbri
DECLARE @Start int
SET @Start = 97
WHILE (@Start <= 122)
BEGIN
	SELECT CHAR (@Start)
	SET @Start = @Start + 1
END
---eemaldab tyhjad kohad sulgudes
SELECT LTRIM('               Hello')

sp_rename 'tblEmployee.Name', 'FirstName'
ALTER TABLE tblEmployee
ADD Lastname
nvarchar;

SELECT * FROM tblEmployee
---tyhikute eemaldamine tabelist
SELECT LTRIM(FirstName) as FirstName, MiddleName, LastName FROM tblEmployee
---parempoolne eemaldamien
SELECT RTRIM('             Hello          ')

---teeb uue kooloni paremale poole ja koik nimed on paremal yhte viirgu pandud
---vastavalt UPPER ja LOWER-ga saan markide suurust muuta
---reverse function saab koik ymber poorata
SELECT REVERSE(UPPER(LTRIM(FirstName))) as FirstName, MiddleName, LOWER(LastName), 
RTRIM(LTRIM (FirstName))+ '  ' + MiddleName + '  ' + LastName as Fullname
FROM tblEmployee
---naeb, mitu tahte on sonal, loeb tyhikud ka sisse, kui panem LTRIM sisse, siis ei kuva
SELECT FirstName, LEN(LTRIM(FIRSTNAME)) as  [Total Characters] FROM tblEmployee


----ylesanne 23,LEFT, RIGHT ja SUBSTRING
use Sample1
SELECT * FROM tblEmployee
ALTER TABLE tblEmployee
ADD Number
nvarchar;

UPDATE tblEmployee
SET Email = 'Sam@aaa.com', Gender = 'Male', DepartmentId = 1, Number = 1
WHERE Id = 1;
---tabel korras
---peal komakohta ytled, mitu tahte soovid kuvada ja kummalt poolt laustab lugemist
SELECT LEFT('ABCDEF', 4)
SELECT RIGHT('ABCDEF', 3)
---esimeses on, mida soovime otsida ja kuvab meile selle jarjekorranumbri
SELECT CHARINDEX ( '@', 'sara@aaa.com')
---esimene nr peale komakohta naitab, mitmendast alustab ja siis mitu nr peale seda kuvada
---antud juhul konkreetne koodirida on jaik, aga kui kasutad ylemist varianti, siis kood on dynaamilisem
SELECT SUBSTRING ('pam@bbb.com', 6, 7)
---kui seal taga on ainult nr, siis kuvab: @bbb.co . Kui paneme + 1, 7, siis kuvab peale @ marki
SELECT SUBSTRING ('pam@bbb.com', CHARINDEX ( '@', 'pam@bbb.com') + 1, 7)
---nyyd peaksime saama iga emailiga niimoodi teha
SELECT SUBSTRING ('pam@bbb.com', CHARINDEX ( '@', 'pam@bbb.com') + 1,
LEN ('pam@bbb.com') - CHARINDEX ( '@', 'pam@bbb.com'))

---kui soovime teatud koolonist saada midagi ja alla paneme tabeli nimetuse
SELECT SUBSTRING (Email, CHARINDEX ( '@', Email) + 1,
LEN (Email) - CHARINDEX ( '@', Email)) AS EmailDomain ---uue kooloni nimetuse
FROM tblEmployee

---nyyd kuvab koik peale @ marki ja siis omakorda teeb kokkuvotte, mitu igat varianti on
SELECT SUBSTRING (Email, CHARINDEX ( '@', Email) + 1,
LEN (Email) - CHARINDEX ( '@', Email)) AS EmailDomain,
COUNT (Email) AS Total ---nyyd saada teada, mitu tk on
FROM tblEmployee
GROUP BY SUBSTRING (Email, CHARINDEX ( '@', Email) + 1,
LEN (Email) - CHARINDEX ( '@', Email))

---ylesanne24, string function nr 2
SELECT * FROM tblEmployee
---mitu korda soovin oma nime korrta
SELECT REPLICATE('Ingvar ', 3)

---asendame *-margiga alates teatud kohast
SELECT FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + --peale teist kohta paneb viis tarni
	SUBSTRING(Email, CHARINDEX('@', Email), LEN(Email) - CHARINDEX('@',Email)+1) AS Email --kuni @margini e dynaamiline kood
FROM tblEmployee

---kui soovin tyhikut khe nime vahele SPACE
SELECT SPACE (5)
SELECT FirstName + SPACE(5) + LastName AS FullName
FROM tblEmployee
---PATINDEX
---sama, mis CHARINEX, aga on dynaamilisem, saab kasutada ka wildcardi
SELECT Email, PATINDEX('%@aaa.com', Email) AS FirstOccurence
FROM   tblEmployee
WHERE  PATINDEX('%@aaa.com', Email) > 0 ---leian koik sellega loppevad emailid ja alates mitmendast margist algab @


---asenda koik .com .net ja tee uude koolonisse loendi
SELECT Email, REPLACE(Email, '.com', '.net') AS ConvertedEmail
FROM tblEmployee

---soovin asendada peale esimest marki kolm tahte viie tarniga
SELECT FirstName, LastName, Email,
		STUFF(Email, 2, 3, '*****') AS StuffedEmail
FROM tblEmployee

---ylesanne 25, date time
---kui soovid ajatabelit teha, siis ei ole kohakohti paika panna
CREATE TABLE tblDateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)
use Sample1
SELECT * FROM tblDateTime

---sellega saan hetke aja koos nanosekundiga
SELECT GETDATE(), 'GETDATE()'
---nyyyd paneme igasse koolonisse aja ja saame erinevat viisi kuvamise
INSERT INTO tblDateTime VALUES (GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE())
---ainult ylemine rida selekteerida ja F5
UPDATE tblDateTime SET c_datetimeoffset = '2012-08-31 11:42:25.0666667 +10:00'
WHERE c_datetimeoffset = '2012-08-31 11:42:25.0666667 +00:00'

---erinevad viisid kuvada aega tabelis
SELECT CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' ---aja paring
SELECT SYSDATETIME(), 'SYSDATETIME' ---tapsem aja paring
SELECT SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' ---tapsem koos ajalise nihkega UTC suhtes
SELECT GETUTCDATE(), 'GETUTCDATE' ---UTC aeg

---ylesanne 26 DateTime
--kui 0, siis vale; kui 1, siis OK
SELECT ISDATE('Ingvar') ---returns 0
SELECT ISDATE(GETDATE()) --returns 1
SELECT ISDATE('2012-08-31 21:02:04.167') --returns 1 ;maksimaalset saab kolm kohta nanosekundi osas
SELECT ISDATE('2012-09-01 11:34:21.1918447') --returns 0
SELECT DAY(GETDATE()) --annab tanase paeva koos paeva nr
SELECT DAY('01/31/2017') --annab ette antud kuupaeva
SELECT MONTH(GETDATE()) --annab kuu nr
SELECT MONTH('01/31/2017') --annab ette antud kuu
SELECT YEAR(GETDATE()) --aasta annab
SELECT YEAR('01/31/2016') --aasta nr annab

SELECT DATENAME(DAY, '2012-04-30 12:34:46.837') --annab 30
SELECT DATENAME(WEEKDAY, '2012-04-30 12:34:46.837') --annab esmaspaeva
SELECT DATENAME(MONTH, '2012-09-30 12:34:46.837')  --annab septembri

SELECT * FROM tblEmployeesWithDates
CREATE TABLE tblEmployeesWithDates
(
Name nvarchar(20),
DateOfBirth datetime,
)
ALTER TABLE tblEmployeesWithDates
ADD Id nvarchar(2);
--sisestan andmed
INSERT INTO tblEmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', ISDATE('1979-11-29 12:59:30.670'));
--uuendan tabeli andmetega
UPDATE tblEmployeesWithDates SET DateOfBirth = '1979-11-29 12:59:30.670'
WHERE Id = 4;
---kuidas votme yhest koolonist ja selle abil loome uue koolonid ning kasutme selle infot
SELECT  Name, DateOfBirth, DateName(WEEKDAY, DateOfBirth) AS [Day], ---vt DoB koolonist paeva jargi ja kuvab paeva nimetuse
		Month(DateOfBirth) AS MonthNumber, ---vt DoB koolonist kuupaev jargi ja kuva kuu nr
		DateName(MONTH, DateOfBirth) AS [MonthName], ---vt DoB kuu jargi ja kuva tahtedena
		Year(DateOfBirth) AS [Year] --vt DoB aasta jargi ja kuvab aasta nr
FROM	tblEmployeesWithDates ---votta sellest tabelist

---ylesanne 27, datetime function nr 2

SELECT DATEPART(WEEKDAY, '2012-08-30 19:45:31.793')  --kuvab 5; annab int vaartuse
SELECT DATENAME(MONTH, '2012-08-30 19:45:31.793')  --kuvab neljapaev; weekday asemel voib panna ka MONTH
SELECT DATEADD(DAY, 20, '2012-08-30 19:45:31.793')  --annab 2012-09-19 19:45:31.793
SELECT DATEADD(DAY, -20, '2012-08-30 19:45:31.793') --annab 2012-08-10 19:45:31.793
SELECT DATEDIFF(MONTH, '11/30/2005','01/31/2006') --kuvab 2 e antud kuude vahe
SELECT DATEDIFF(YEAR, '11/30/2005','01/31/2006') --kuvab 62 kuvab paevade vahe

SELECT * FROM tblEmployeesWithDates


----votab arvesse tabelis oleva algusaja ja siis arvutab kuni tanapaevani valja e loime sp
CREATE FUNCTION fnComputeAge(@DOB DATETIME)
RETURNS NVARCHAR(50)
AS
BEGIN

	DECLARE @tempdate DATETIME, @years INT, @months INT, @days INT
		SELECT @tempdate = @DOB

		SELECT @years = DATEDIFF(YEAR, @tempdate, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END
		SELECT @tempdate = DATEADD(YEAR, @years, @tempdate)

		SELECT @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - CASE WHEN DAY(@DOB) > DAY(GETDATE()) THEN 1 ELSE 0 END
		SELECT @tempdate = DATEADD(MONTH, @months, @tempdate)

		SELECT @days = DATEDIFF(DAY, @tempdate, GETDATE())

	DECLARE @Age NVARCHAR(50)
		SET @Age = Cast(@years AS  NVARCHAR(4)) + ' Years ' + Cast(@months AS  NVARCHAR(2))+ ' Months ' +  Cast(@days AS  NVARCHAR(2))+ ' Days Old'
	RETURN @Age

End

SELECT dbo.fnComputeAge('11/30/2005')

---nyyd saame igayhe vanust naha
SELECT Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) 
AS Age FROM tblEmployeesWithDates

---ylesanne28 cast ja convert funktsioone; soovitav ei oleks DoB pikkust maaratleda, siis ei nae kogu ulatuses
SELECT Id, Name, DateOfBirth, CAST(DateOfBirth AS nvarchar) AS ConvertedDOB FROM tblEmployeesWithDates
SELECT Id, Name, DateOfBirth, CONVERT(nvarchar, DateOfBirth) AS ConvertedDOB FROM tblEmployeesWithDates

SELECT CAST(GETDATE() as DATE) --tanane kuupaev
SELECT CONVERT(DATE, GETDATE()) --tanane kuupaev
--Cast tuleb panna kuna Id on int ja ei saa int panna lahtrisse, mis on nvarchar
SELECT Id, Name, Name + ' - ' + CAST(Id AS nvarchar) AS [Name-Id] FROM tblEmployeesWithDates  --saan Sam - 1 jne

---saan erinevalt kuvada kuupaevasid, kui muudan DOB, jarel tulevat nr
SELECT Id, Name, DateOfBirth,
CONVERT(nvarchar, DateOfBirth, 104) AS ConvertedDOB
FROM tblEmployeesWithDates

CREATE TABLE tblRegistrations
(
Id nvarchar(2),
Name nvarchar(20),
Email nvarchar (20),
RegisteredDate datetime
)

INSERT INTO tblRegistrations  (Id, Name, Email, RegisteredDate)  
VALUES (6, 'Mike', 'mike@m.com', '2012-08-26 15:05:30.330');
--uuendan tabeli andmetega
UPDATE tblRegistrations SET RegisteredDate = '2012-08-24 15:04:30.330'
WHERE Id = 5;

SELECT * FROM tblRegistrations

---siin ei saanud me midagi teada koondtabelisse ja ei tee groupimist kuna keegi ei ole tapselt samal ajal kylastanud
SELECT		RegisteredDate, COUNT(Id) AS TOTAL 
FROM		tblRegistrations
GROUP BY	RegisteredDate
---nyyd peaksime saama paeva loikes teada, kui palju kylastas
SELECT		CAST(RegisteredDate AS DATE) as RegistrationDate, COUNT(Id) AS Total 
FROM		tblRegistrations
GROUP BY	CAST(RegisteredDate AS DATE)
--Convert annab rohkem paindlikust, kui Cast, Cast ei saa kasutada style parameetrit

---ylesanne 29, Matemaatilised funktsioonid

SELECT ABS(-101.5) --ABS on absoluutne nr ja tulemuseks saame ilma - margi
SELECT CEILING(15.2) --returns 16, kuvab jargmise suurema nr
SELECT CEILING(-15.2) --annab -15, positiivse nr kohalt on -15 suurem
SELECT FLOOR(15.2) --anna 15, siin allapoole arvestab
SELECT FLOOR(-15.2) --anna -16, siin allapoole arvestab
SELECT POWER(2,4) --hakkab korrutama 2x2x2x2; peale komakohta on esimese nr arv
SELECT SQUARE(9) --antud juhul 9 ruudus
SELECT SQRT(81) --annab vastuse 9

SELECT RAND(1) --annab alati yhe nr; kui tahad suvalist nr iga kord, siis ara pane nr sulgudesse
SELECT FLOOR (RAND() * 100) --korrutad sajaga iga suvalise nr


--niimoodi saab 10 suvalist nr kuvada
DECLARE @Counter int
SET @Counter = 1
WHILE (@Counter <= 10)
BEGIN
	Print FLOOR(RAND() * 1000) --kui paned 1000 uue nr, siis hakkab teise nr korrutama
	Set @Counter = @Counter + 1
End

SELECT ROUND(850.556, 2) --ymardab peale 85 ja tulemus on 850.560

SELECT ROUND(850.556, 2, 1) --saab ymardada nr peale 85, aga 1 tahendab, et korgemale

SELECT ROUND(850.556, 1) --850.600

SELECT ROUND(850.556, 1,1) --ymardab 850.500

SELECT ROUND(850.556, -2) --900.000; kaks esimest ymarda suuremaks

SELECT ROUND(850.556, -1) --850.00; peale koma suurenda

--ylesanne 30  user defined functions
use Sample1

SELECT dbo.CalculateAge ('10/08/1982') AS Age --allpool on selle funktsiooni loomine. dbo ette voib panna ka Sample, aga vahet ei ole.

CREATE FUNCTION CalculateAge (@DOB Date)
RETURNS INT
AS
BEGIN
DECLARE @Age INT

--DECLARE @DOB DATE  ---loime muutuja DOB
--DECLARE @Age INT   ---ja Age, mis on int
--SET @DOB ='10/08/1982' ---synnipaev

SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - 
	CASE
		WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
			 (MONTH(@DOB) > MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
		THEN 1
		ELSE 0
		END
RETURN @Age 
END
--loob Scalar-valued Functionsi alla CalculateAge. dbo -database owner

SELECT * FROM tblEmployeesWithDates
--arvutab valja, kui vana on keegi ja votab arvesse paev ja kuu
SELECT Id, Name, dbo.CalculateAge(DateOfBirth) AS Age FROM tblEmployeesWithDates
--kui paneme alumise rea, siis annab koik, kes on vanemad , kui 35. Muuda vanust ja vaata.
WHERE dbo.CalculateAge(DateOfBirth) > 36

Sp_helptext CalculateAge

EXECUTE spCalculateAge '10/08/1982'
--functionit saab kasutada where select klassis, aga storedProceedure ei saa
--see on scalar valued functioni eelis sp ees dbo on parem

---ylesanne31  Inline Table Valued Functions

ALTER TABLE tblEmployeesWithDates
ADD DepartmentId int;

UPDATE tblEmployeesWithDates SET Gender = 'Female' , DepartmentId = 3
WHERE Id =4;

INSERT INTO tblEmployeesWithDates (Id, Name, DateOfBirth, Gender, DepartmentId)
VALUES (5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 1);

--scalare function annab mingis vahemikus olevaid andmeid, aga 
--inline tabled values ei kasuta me begin ja end funktsioone, see oleks error
--scalar annab vaartused, aga inline annab tabeli
CREATE FUNCTION fn_EmployeesByGender(@Gender nvarchar(10))
RETURNS TABLE
AS
RETURN (Select Id, Name, DateOfBirth, Gender, DepartmentId --siin tapsustad, mida soovid kuvada e return
	   FROM tblEmployeesWithDates --mis tabelist
	   WHERE Gender = @Gender) --sugu parameetri alt

--seda funktsiooni tuleb kohelda nagu tabelit
SELECT * FROM fn_EmployeesByGender ('Female') --kui soovime ainult soo jargi otsida
WHERE Name = 'Pam' --saab veel tapsemalt otsida, nt koik Pam-d ja naised

SELECT * FROM tblDepartment

INSERT INTO tblDepartment (Id, DepartmentName, Location, DepartmentHead)
VALUES (4, 'Other Department', 'Sydney', 'Cindrella')

UPDATE tblDepartment SET Location = 'London'
WHERE Id =1;

SELECT * FROM  tblEmployeesWithDates
SELECT * FROM tblDepartment

--kahest erinevast tabelist andmete votmine  ja koos kuvamine
SELECT Name, Gender, DepartmentName  --kuvab koolonid uues tablis
FROM   fn_EmployeesByGender('Male') E  --loodud funktsioon, millele on antud alias nimega E
JOIN   tblDepartment D ON D.Id = E.DepartmentId  --nyyd antakse alias tblDepartment-le nimetusega D = iga D ehk tblDepartment all olev koolon nimega Id otsib ylesse koik Male-d tabelist aliasega E

use Sample1
---ylesanne 32; multi-statment table

--Inline table valued function, ei ole end ja begin classi
CREATE FUNCTION fn_ILTVF_GetEmployees()
RETURNS TABLE
AS
RETURN (Select Id, Name, CAST(DateOfBirth AS DATE) 
		AS DOB 
		FROM tblEmployeesWithDates) 

SELECT * FROM fn_ILTVF_GetEmployees()

--multi-state Table Valued Function, pead defineerima uue tabeli koolonid koos muutujatega		
CREATE FUNCTION fn_MSTVF_GetEmployees()  --loon funktsiooni
RETURNS @Table Table (Id int, Name nvarchar(20), DOB Date) --loon uue tabeli (ja sulgudes on tulevaste koolonite nimetused). Selle funktsiooni puhul peab tapsustama koolonite nimetuse.
AS
BEGIN
	INSERT INTO @Table --sisesta tabelisse nimega Table andmed
	SELECT Id, Name, CAST(DateOfBirth AS DATE) FROM tblEmployeesWithDates --tabelist nimega tblEmployeesWithDates, panen date kuna ei soovi tapaet kellaaega kuvada uues tabelis

	RETURN
END

SELECT * FROM fn_MSTVF_GetEmployees()
---inline table funktsioonid on paremad toimimas. SQL kasitleb seda kui vaadet. Multi varianti kasitleb SQL kui stored procedure-na
---nyyd uuendame funktsiooni
UPDATE fn_ILTVF_GetEmployees() SET Name = 'Sam1' WHERE Id = 1 ---Nyyd on ta nimi Sam1
UPDATE fn_MSTVF_GetEmployees() SET Name = 'Sam 1' WHERE Id = 1 --sellega ei saa uuendusi teha kuna ei ole konkreeteselt teada, kus andmeid saadakse

---ylesanne 33  deterministic ja nondeterministic
SELECT * FROM tblEmployeesWithDates

SELECT COUNT(*) FROM tblEmployeesWithDates --mitu rida on tabelis
SELECT SQUARE(3) --koik tehtemargid on deterministlikud funktsioonid: sum, AVG, Square

--nondeterministic
SELECT GETDATE()
SELECT CURRENT_TIMESTAMP
SELECT RAND() --see saab molemas kategoorias olla, koik oleneb kas sulgudes on 1 voi ei ole

--loome funktsiooni
CREATE FUNCTION fn_GetNameById(@id int)
RETURNS nvarchar(30)
AS
BEGIN
	RETURN (SELECT Name FROM tblEmployeesWithDates WHERE Id = @Id) --id nr alusel saan teada, kes asub vastavas reas
END

SELECT dbo.fn_GetNameById(1) 

--muudan funktsooni ja krypteerin ara
ALTER FUNCTION fn_GetNameById(@id int)  
RETURNS nvarchar(30) 
WITH ENCRYPTION  
AS  
BEGIN  
 RETURN (SELECT Name FROM tblEmployeesWithDates WHERE Id = @Id)  
END

DROP TABLE tblEmployeesWithDates

CREATE TABLE [dbo].[tblEmployeesWithDates]
(
	[Id] [int] Primary Key,
	[Name] [nvarchar](50) NULL,
	[DateOfBirth] [datetime] NULL,
	[Gender] [nvarchar](10) NULL,
	[DepartmentId] [int] NULL
)

INSERT INTO tblEmployeesWithDates VALUES(1,'Sam','1980-12-30 00:00:00.000','Male',1)
INSERT INTO tblEmployeesWithDates VALUES(2,'Sam','1982-09-01 12:02:36.260','Female',2)
INSERT INTO tblEmployeesWithDates VALUES(3,'Sam','1985-08-22 12:03:30.370','Male',1)
INSERT INTO tblEmployeesWithDates VALUES(4,'Sam','1979-11-29 12:59:30.670','Female',3)
INSERT INTO tblEmployeesWithDates VALUES(5,'Sam','1978-11-29 12:59:30.670','Male',1)

--selle funktsiooniga olen kinnitanud funktsiooni selle tabeli olemasoluga ja ilma seda kustutamat ei saa tablit kustutata
--niimoodi ei saa igayks sinu teadmata kustutata ja rikkuda tabelit
ALTER FUNCTION fn_GetNameById(@id int)  
RETURNS nvarchar(30) 
WITH SCHEMABINDING  --selle kasklusega
AS  
BEGIN  
 RETURN (SELECT Name FROM dbo.tblEmployeesWithDates WHERE Id = @Id)  
END

---ylesanne 34; temporary tables

---temporary table loomine
---esimese yhenduse loomise saab aru # margi jargi
---seda tabelit saab ainult siin avada uuesti, uues paringus ei saa
use Sample1

CREATE TABLE #PersonDetails(Id int, Name nvarchar(20)) -- seda tabelit saab vaadata system database alt tempdb alt

INSERT INTO #PersonDetails VALUES(1, 'Mike')
INSERT INTO #PersonDetails VALUES(2, 'John')
INSERT INTO #PersonDetails VALUES(3, 'Todd')
--kui vaatad object exploreri alt, siis tabelit ei ole Sample1 all
SELECT * FROM #PersonDetails

SELECT name FROM tempdb..sysobjects
WHERE name LIKE '#PersonDetails%' --tuleb kasutada LIKE sona kuna muidu ei leia ylesse ja lisaks veel wildcard meetodi, et kuvaks lahtrisse PersonDetails
--ajutise tabeli saab kustuta, kui sulgeme paringu, veel saab kasutada ka DROP TABLE


--loon ajutise sp ja mida saan kasutada ainult yhe korra
--teisel korral saad eitava vastuse
CREATE PROCEDURE spCreateLocalTempTable
AS
BEGIN
CREATE TABLE #PersonDetails(Id int, Name nvarchar(20))

INSERT INTO #PersonDetails VALUES(1, 'Mike')
INSERT INTO #PersonDetails VALUES(2, 'John')
INSERT INTO #PersonDetails VALUES(3, 'Todd')

SELECT * FROM #PersonDetails
END
--siin naha andmeid
--void molemasse paringusse ka teha samasuguse andmete sisestamine ja siis tekib kaks ajutist paringut
EXECUTE spCreateLocalTempTable
--siin ei saa
SELECT * FROM #PersonDetails

--global temp tabelid saab luua, kui kasutad tabeli nime ees ##
CREATE TABLE ##PersonDetails(Id int, Name nvarchar(20))
--mis vahe on nendel: localid yhenduses loppevad, kui paring on kinni pandud, aga global loppeb, kui yhendus katkeb

---yhendus 35: index

--kasutatakse kiiresti leidmise puhul

CREATE TABLE tblEmployeeWithSalary
(
	[Id] [int] Primary Key,
	[Name] [nvarchar] (25),
	[Salary] [int],
	[Gender] [nvarchar]
)
INSERT INTO tblEmployeeWithSalary VALUES(1,'Sam', 2500,'Male')
INSERT INTO tblEmployeeWithSalary VALUES(2,'Pam', 6500,'Female')
INSERT INTO tblEmployeeWithSalary VALUES(3,'John',4500,'Male')
INSERT INTO tblEmployeeWithSalary VALUES(4,'Sara',5500,'Female')
INSERT INTO tblEmployeeWithSalary VALUES(5,'Todd',3100,'Male')
--hetkel on mul vaga raske orienteeruda, kus mis asub jne, kui kasutan allolevat otsingut
SELECT * FROM tblEmployeeWithSalary
WHERE Salary > 5000 AND Salary < 7000
---
CREATE Index IX_tblEmployee_Salary  ---inedx puhul paneme ette IX
ON tblEmployeeWithSalary (SALARY ASC) ---ASC on vaiksemast suurema poole jarjestamine

sp_Helpindex tblEmployeeWithSalary

DROP INDEX tblEmployeeWithSalary.IX_tblEmployee_Salary --mis tabeli oma ja siis tapne sp nimetus

---ylesanne 36: index types

CREATE TABLE tblEmployeeCity
(
	[Id] [int] Primary Key,
	[Name] [nvarchar] (50),
	[Salary] [int],
	[Gender] [nvarchar](10),
	[City] [nvarchar] (50)
)

EXECUTE sp_helpindex tblEmployeeCity
SELECT * FROM tblEmployeeCity
--kui olen kasutanud clustered index-it, siis automaatselt jarjestab andmed
INSERT INTO tblEmployeeCity VALUES(3,'John',4500,'Male','New York')
INSERT INTO tblEmployeeCity VALUES(1,'Sam', 2500,'Male','London')
INSERT INTO tblEmployeeCity VALUES(4,'Sara',5500,'Female','Tokyo')
INSERT INTO tblEmployeeCity VALUES(5,'Todd',3100,'Male','Toronto')
INSERT INTO tblEmployeeCity VALUES(2,'Pam', 6500,'Female','Sydney')

--kui tabelis on mitu koolonit, siis kutsume seda composite index-ks
--saame ka sugu ja palga jargi panna paika, enne sugu ja siis alles palga jargi
--enne peame clustered indexi eemaldama

--composite index ja saad ainult yhe clustered index-t omada
--see on kiirem kuna cluster kuna ei pea minema tagasi tabeli juurde
--clustered index lihtsalt loob korra tabelis, mitte ei lahe sinna ringiga
CREATE CLUSTERED INDEX IX_tblEmployeeCity_Gender_Salary
ON tblEmployeeCity(Gender DESC, Salary ASC)
--votab aluseks esimesena arvesse sugu ja alles siis palga

--loon nime juurde nonclustered indexi
CREATE NONCLUSTERED INDEX IX_tblEmployeeCity_Name
ON tblEmployeeCity(Name)

SELECT * FROM tblEmployeeCity

---ylesanne 37: unique ja non-unique index
use Sample1
SELECT * FROM tblEmployeeCity

sp_Rename 'tblEmployeeCity.Name', 'Firstname'
ALTER TABLE tblEmployeeCity
ADD	LastName nvarchar(25);

UPDATE tblEmployeeCity 
SET Id = 1,
FirstName = 'Mike', 
LastName = 'Sandoz',
Salary = 4500,
Gender = 'Male',
City = 'New York'
WHERE ID = 1;
---selekteerib vahemiku WHERE abil
SELECT * FROM tblEmployeeCity WHERE Salary > 4000 AND Salary < 8000
---kustuta ja uuenda 
DELETE FROM tblEmployeeCity WHERE Salary = 2500
UPDATE tblEmployeeCity SET Salary = 9000 WHERE Salary = 7500
---jarjesta alla langevas ja ylenevas jarjekorras
SELECT * FROM tblEmployeeCity ORDER BY Salary
SELECT * FROM tblEmployeeCity ORDER BY Salary DESC
---Ryhmitame, kui palju on selle summaga inimesi
SELECT Salary, COUNT(Salary) AS Total
FROM tblEmployeeCity
GROUP BY Salary
---negatiivse pooled index-i puhul
--1:clustered index ei vaja uut ruumi, aga non see-eest vajab.
--2:kui teen data muudatust(DML), siis koik teised indexid muutuvad utomaatselt ja see aeglustab

---ylesanne 39: views

ALTER TABLE tblDepartment
DROP COLUMN DepartmentHead;

SELECT * FROM tblDepartment
SELECT * FROM tblEmployeeCity
ALTER TABLE tblEmployeeCity
DROP COLUMN LastName;
sp_Rename 'tblDepartment.Id', 'DeptId'

--view loomine
CREATE VIEW vEmployeesByDepartment
AS
SELECT Id, Name, Salary, Gender, DeptName --naita neid kooloneid
FROM tblEmployeeCity  --sellest tabelist
JOIN tblDepartment  --vii kokku allolevas koolonis olevad nr
ON tblEmployeeCity.DepartmentId = tblDepartment.DeptId --yhendatavad koolonid

--mine tee Sample1 View kasutast refresh ja vaata
--kirjuta alumine funktsioon ja F5
--sellega saab arvuti aru, et nendest kahest tabelist tuleb votta andmed 
--ning yhitada osakondade Id-d ning kuvada(see ei talleta andmeid, lihtsalt virtuaalne tabel)

SELECT * FROM vEmployeesByDepartment

--ainult IT osakonna tootajaid naeks
CREATE VIEW vWITEmployees
AS
SELECT Id, Name, Salary, Gender, DeptName
FROM tblEmployeeCity
JOIN tblDepartment 
ON tblEmployeeCity.DepartmentId = tblDepartment.DeptId
WHERE tblDepartment.DeptName = 'IT'

SELECT * FROM vWITEmployees

--nyyd paneme palga kinni, selleks on vaja esimesest reast kustutada Salary koolon
CREATE VIEW vWNonConfidentialData
AS
SELECT Id, Name, Gender, DeptName
FROM tblEmployeeCity
JOIN tblDepartment 
ON tblEmployeeCity.DepartmentId = tblDepartment.DeptId

SELECT * FROM vWNonConfidentialData

--kokku arvutav view, kui palju igas osakonnas tootab
CREATE VIEW vWSummarizeData
AS
SELECT DeptName, COUNT(Id) AS TotalEmployees
FROM tblEmployeeCity
JOIN tblDepartment
ON tblEmployeeCity.DepartmentId = tblDepartment.DeptId
GROUP BY DeptName

SELECT * FROM vWSummarizeData


---ylesanne 40: updateable views
--loome tabelist view
SELECT * FROM tblDepartment
SELECT * FROM tblEmployeeCity

CREATE VIEW vWEmployeesDataExceptSalary
AS
SELECT Id, Name, Gender, DepartmentId 
FROM tblEmployeeCity

SELECT * FROM vWEmployeesDataExceptSalary
--view update ja teeb sama ka pohitabelis
UPDATE vWEmployeesDataExceptSalary
SET Name = 'Mikey' WHERE Id = 2

DELETE FROM vWEmployeesDataExceptSalary WHERE Id = 2
INSERT INTO vWEmployeesDataExceptSalary VALUES (2, 'Mikey', 'Male', 2)

---view osakonna kaupa
CREATE VIEW vwEmployeesDetailsByDepartment
AS
SELECT Id, Name, Salary, Gender, DeptName
FROM tblEmployeeCity
JOIN tblDepartment
ON tblEmployeeCity.DepartmentId = tblDepartment.DeptId

SELECT * FROM vwEmployeesDetailsByDepartment
--uuendame andmeid John puhul, et ta on HR asemel nyyd IT, aga tegime eskikombel ka Ben-i IT tootajaks
UPDATE vwEmployeesDetailsByDepartment
SET DeptName ='IT' WHERE Name = 'John'

SELECT * FROM vwEmployeesDetailsByDepartment

---ylesanne 41: Index views
SELECT * FROM tblProductSales

CREATE TABLE tblProductSales
(
	ProductId int,
	QuantitySold int
)

--kasutada schemabindingut, kui kavatsed indexit kasutada. 
CREATE VIEW vWTotalSalesByProduct
WITH SCHEMABINDING
AS
SELECT Name,
SUM(ISNULL((QuantitySold * UnitPrice), 0)) AS TotalSAles, --korrutame kaks lahtrit omavahel, kui on voimalus, et tuleb null, siis tuleb kasutada ISNULL ja , 0
COUNT_BIG(*) AS TotalTransactions
FROM dbo.tblProductSales
JOIN dbo.tblProduct
ON dbo.tblProduct.ProductId = dbo.tblProductSales.ProductId
GROUP BY Name

SELECT * FROM vWTotalSalesByProduct
--nyyd peaks olema systems views all cluster, enam ei lahe baastabelisse arvutama ja alles siis annab andmeid
CREATE UNIQUE CLUSTERED INDEX UIX_vWTotalSalesByProduct_Name
ON vWTotalSalesByProduct(Name)

---ylesanne 42: view piirangud

SELECT * FROM tblEmployeeCity

--view on virtuaalse tabelid ja neid ei ole sailitatud kuskile
CREATE VIEW vWEmployeeDetails
AS
SELECT  Id, Name, Gender, DepartmentId
FROM	tblEmployeeCity

SELECT * FROM vWEmployeeDetails
WHERE Gender = 'Male'

--funktsiooni loomine nagu view puhul
CREATE FUNCTION fnEmployeeDetails(@Gender nvarchar(20))
RETURNS TABLE
AS
RETURN
(SELECT Id, Name, Gender, DepartmentId
FROM tblEmployeeCity WHERE Gender = @Gender)

SELECT * FROM dbo.fnEmployeeDetails('Male')
--view-sid ja funktsioone ei saa olla ka temp tabelid

---ylesanne 43: triggers, DML triggers
use Sample1
SELECT * FROM tblEmployee
SELECT * FROM tblEmployeeAudit

CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)

Insert into tblEmployee values (4,'Todd', 4800, 'Male', 4)
Insert into tblEmployee values (5,'Sara', 3200, 'Female', 1)
Insert into tblEmployee values (6,'Ben', 4800, 'Male', 3) 

CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)


ALTER TRIGGER tr_tblEMployee_ForInsert
ON tblEmployee
FOR INSERT
AS
BEGIN
	Declare @Id int
	Select @Id = Id from inserted
 
	insert into tblEmployeeAudit 
	values('New employee with Id  = ' + Cast(@Id as nvarchar(5)) + ' is added at ' + cast(Getdate() as nvarchar(20)))
END

--kui selle rea sisestame DB-sse, siis trigger laheb kaiku
INSERT INTO tblEmployee VALUES (9, 'Jimmy', 1800, 'Male', 3)

---kustutame andmeid labi triggeri
CREATE TRIGGER tr_tblEMployee_ForDelete
ON tblEmployee
FOR DELETE
AS
BEGIN
	Declare @Id int
	Select @Id = Id from deleted
 
	insert into tblEmployeeAudit 
	values('An existing employee with Id  = ' + Cast(@Id as nvarchar(5)) + ' is deleted at ' + cast(Getdate() as nvarchar(20)))
END

DELETE FROM tblEmployee WHERE Id = 8

SELECT * FROM tblEmployeeAudit

---ylesanne44:  DML triggers
SELECT * FROM tblEmployee
SELECT * FROM tblDepartment

CREATE TRIGGER tr_tblEmployee_ForUpdate
ON tblEmployee
FOR Update
AS
BEGIN
	SELECT * FROM  deleted
	SELECT * FROM inserted 
END
--naitab enne ja nyyd olevaid andmeid
Update tblEmployee set Name = 'Todd', Salary = 2350, 
Gender = 'Male' where Id = 4

---muudame triggeri nime
Alter trigger tr_tblEmployee_ForUpdate
on tblEmployee
for Update
as
Begin
      -- Declare variables to hold old and updated data
      Declare @Id int
      Declare @OldName nvarchar(20), @NewName nvarchar(20)
      Declare @OldSalary int, @NewSalary int
      Declare @OldGender nvarchar(20), @NewGender nvarchar(20)
      Declare @OldDeptId int, @NewDeptId int
     
      -- Variable to build the audit string
      Declare @AuditString nvarchar(1000)
      
      -- Load the updated records into temporary table
      Select *
      into #TempTable
      from inserted
     
      -- Loop thru the records in temp table
      While(Exists(Select Id from #TempTable))
      Begin
            --Initialize the audit string to empty string
            Set @AuditString = ''
           
            -- Select first row data from temp table
            Select Top 1 @Id = Id, @NewName = Name, 
            @NewGender = Gender, @NewSalary = Salary,
            @NewDeptId = DepartmentId
            from #TempTable
           
            -- Select the corresponding row from deleted table
            Select @OldName = Name, @OldGender = Gender, 
            @OldSalary = Salary, @OldDeptId = DepartmentId
            from deleted where Id = @Id
   
     -- Build the audit string dynamically           
            Set @AuditString = 'Employee with Id = ' + Cast(@Id as nvarchar(4)) + ' changed'
            if(@OldName <> @NewName)
                  Set @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' + @NewName
                 
            if(@OldGender <> @NewGender)
                  Set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
            if(@OldSalary <> @NewSalary)
                  Set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))
                  
     if(@OldDeptId <> @NewDeptId)
                  Set @AuditString = @AuditString + ' DepartmentId from ' + Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))
           
            insert into tblEmployeeAudit values(@AuditString)
            
            -- Delete the row from temp table, so we can move to the next row
            Delete from #TempTable where Id = @Id
      End
End

---ylesanne 45: insert trigger
SELECT * FROM tblEmployee
SELECT * FROM tblDepartment

UPDATE tblDepartment SET DeptName = 'HR'
WHERE DeptId = 3;

CREATE VIEW vWEmployeeDetails
AS
SELECT Id, Name, Gender, DeptName
FROM tblEmployee 
JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.DeptId

SELECT * FROM vWEmployeeDetails

INSERT INTO vWEmployeeDetails VALUES ( 7, 'Valarie', 'Female', 'IT')

---loome triggeri eelmise view jaoks
ALTER TRIGGER tr_vWEmployeeDetails_InsteadOfInsert
ON vWEmployeeDetails
INSTEAD OF INSERT
AS
BEGIN

	DECLARE @DeptId int
 
	--Check if there is a valid DepartmentId
	--for the given DepartmentName
	SELECT @DeptId = DeptId --kui keegi peaks mingi suvalise osakonnanime panema, siis vastus on null, vt alla
	FROM tblDepartment 
	JOIN inserted
	ON inserted.DeptName = tblDepartment.DeptName
 
	--If DepartmentId is null throw an error
	--and stop processing
	IF(@DeptId is null) ---kui vastus on null, siis annab alloleva vastuse
	BEGIN
	Raiserror('Invalid Department Name. Statement terminated', 16, 1)
	RETURN
	END

	--kui osakonna nimetus on korrektne
	INSERT INTO tblEmployee(Id, Name, Gender, DepartmentId)
	SELECT Id, Name, Gender, @DeptId
	FROM inserted
END

DELETE FROM tblEmployee WHERE Id = 7;
---ylesanne 46: 

SELECT * FROM vWEmployeeDetails

--ei saa teha kuna mitut tabelit mojutab
UPDATE vWEmployeeDetails SET Name = 'Johny', DeptName = 'IT' WHERE Id = 1

--see mojutab ainult yhte baastabelit ja seega probleeme ei peaks olema
UPDATE vWEmployeeDetails SET DeptName = 'IT'  WHERE Id = 1
--teeme osakondade tabeli korrektseks
UPDATE vWEmployeeDetails SET DeptName = 'IT'  WHERE Id = 1

--loome triggeri
CREATE TRIGGER tr_vWEmployeeDetails_InsteadOfUpdate
ON vWEmployeeDetails
INSTEAD OF UPDATE
AS
BEGIN
 -- if EmployeeId is updated
	if(UPDATE(Id))
	BEGIN
		Raiserror('Id cannot be changed', 16, 1)
		Return
	END
 
 -- If DeptName is updated
	if(UPDATE(DeptName)) 
	BEGIN 
		DECLARE @DeptId int

		SELECT @DeptId = DeptId
		FROM tblDepartment
		JOIN inserted
		ON inserted.DeptName = tblDepartment.DeptName
  
		if(@DeptId is NULL )
		BEGIN
			Raiserror('Invalid Department Name', 16, 1)
			Return
		END
  
		UPDATE tblEmployee SET DepartmentId = @DeptId
		FROM inserted
		JOIN tblEmployee
		ON tblEmployee.Id = inserted.id
	END
 
 -- If gender is updated
	if(UPDATE(Gender))
	BEGIN
		UPDATE tblEmployee SET Gender = inserted.Gender
		FROM inserted
		JOIN tblEmployee
		ON tblEmployee.Id = inserted.id
	END
 
 -- If Name is updated
	if(UPDATE(Name))
	BEGIN
		UPDATE tblEmployee SET Name = inserted.Name
		FROM inserted
		JOIN tblEmployee
		ON tblEmployee.Id = inserted.id
	END
END

UPDATE tblEmployee SET Name = 'John', Gender = 'Male', DepartmentId = 3
WHERE Id = 1

SELECT * FROM vWEmployeeDetails
SELECT * FROM tblEmployee
SELECT * FROM tblDepartment
---ylesanne 48: delete trigger

CREATE VIEW vWEmployeeCount
AS
SELECT DeptName, DepartmentId, COUNT(*) AS TotalEmployees
FROM tblEmployee
JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.DeptId
GROUP BY DeptName, DepartmentId

SELECT * FROM vWEmployeeCount

---naitab, kus on rohkem, kui kaks tootajat
SELECT DeptName, TotalEmployees FROM vWEmployeeCount
WHERE TotalEmployees >= 2

---temp e ajutise tabeli loomine ja siis info katte saamine
SELECT DeptName, DepartmentId, COUNT(*) AS TotalEmployees
INTO #TempEmployeeCount
FROM tblEmployee
JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.DeptId
GROUP BY DeptName, DepartmentId

SELECT * FROM #TempEmployeeCount
---tabeli paring
SELECT DeptName, TotalEmployees
FROM #TempEmployeeCount
WHERE TotalEmployees >= 2
---tabeli elimineerimine
DROP TABLE #TempEmployeeCount

---kasutan table variable saamaks teada, mitu inimest on igas osakonnas
DECLARE @tblEmployeeCount TABLE(DeptName nvarchar(20), DepartmentId int, TotalEmployees int)

INSERT @tblEmployeeCount
SELECT DeptName, DepartmentId, COUNT(*) AS TotalEmplyees
FROM tblEmployee
JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.DeptId
GROUP BY DeptName, DepartmentId

SELECT DeptName, TotalEmployees
FROM @tblEmployeeCount
WHERE TotalEmployees >=2

---seda AS peale kasitletakse, kui uut tabelit. Sulgudes koondame koik kokku 
---ja votame ainult esimese rea SELECT-i jarel oleva kokku
SELECT DeptName, TotalEmployees
FROM
	(
		SELECT DeptName, DepartmentId, COUNT(*) AS TotalEmployees
		FROM tblEmployee
		JOIN tblDepartment
		ON tblEmployee.DepartmentId = tblDepartment.DeptId
		GROUP BY DeptName, DepartmentId
	)
AS EmpoyeeCount
WHERE TotalEmployees >= 2

---CTE on sarnane tuletatud tabelile ja ei ole talletatud nagu objektile ja kestab paringu aja jooksul
---see on temp tabel
WITH EmpoyeeCount(DeptName, DeparmtentId, TotalEmployees)
AS
	(
		SELECT DeptName, DepartmentId, COUNT(*) AS TotalEmployees
		FROM tblEmployee
		JOIN tblDepartment
		ON tblEmployee.DepartmentId = tblDepartment.DeptId
		GROUP BY DeptName, DepartmentId
	)
SELECT DeptName, TotalEmployees
FROM EmpoyeeCount
WHERE TotalEmployees >= 2


---ylesanne 50: CTE e common table expression
SELECT * FROM tblEmployee

WITH Employees_Name_Gender
AS
(
 SELECT Id, Name, Gender from tblEmployee
)
UPDATE Employees_Name_Gender SET Gender = 'Female' where Id = 1

---CTE kasutamine, mitu tootajat on igas osakonnas
WITH EmployeeCount (DepartmentId, TotalEmployees)
AS
	(
		SELECT DepartmentId, COUNT(*) AS TotalEmployees
		FROM tblEmployee
		GROUP BY DepartmentId
	)
SELECT DeptName, TotalEmployees
FROM tblDepartment
JOIN EmployeeCount
ON tblDepartment.DeptId = EmployeeCount.DepartmentId
ORDER BY TotalEmployees


---nyyd lisame eelmisega vorreldes SELECT 'Hello'
WITH EmployeeCount (DepartmentId, TotalEmployees)
AS
	(
		SELECT DepartmentId, COUNT(*) AS TotalEmployees
		FROM tblEmployee
		GROUP BY DepartmentId
	)
--SELECT 'Hello'
SELECT DeptName, TotalEmployees
FROM tblDepartment
JOIN EmployeeCount
ON tblDepartment.DeptId = EmployeeCount.DepartmentId
ORDER BY TotalEmployees

---saab kasutada ka rohkem, kui yhte CTE, kui eraldad need komadega
WITH EmployeesCountBy_Payroll_IT_Dept(DepartmentName, Total)
AS
	(
		SELECT DeptName, COUNT(Id) AS TotalEmployees
		FROM tblEmployee
		JOIN tblDepartment
		ON tblEmployee.DepartmentId = tblDepartment.DeptId
		WHERE DeptName IN ('Payroll','IT')
		GROUP BY DeptName
	),
EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
AS
	(
		SELECT DeptName, COUNT(Id) AS TotalEmployees
		FROM tblEmployee
		JOIN tblDepartment
		ON tblEmployee.DepartmentId = tblDepartment.DeptId
		WHERE DeptName IN ('HR','Admin')
		GROUP BY DeptName
	)
SELECT * FROM EmployeesCountBy_Payroll_IT_Dept
UNION
SELECT * FROM EmployeesCountBy_HR_Admin_Dept
---koik koos tuleb aktiveerida

---ylesanne 51: updatable CTE
SELECT * FROM tblEmployee

CREATE TABLE tblEmployee
(
	EmployeeId int Primary key,
	Name nvarchar(20),
	ManagerId int
)

SELECT * FROM tblEmployee

DELETE FROM tblEmployeeByGender
WHERE Id = 7 ;

EXEC sp_rename 'EmloyeeByGender', 'tblEmloyeeByGender'; 

WITH Employees_Name_Gender
AS
(
	SELECT Id, Name, Gender FROM tblEmployee
)
UPDATE Employees_Name_Gender SET Gender = 'Female' WHERE Id = 1


WITH EmployeesByDepartment
AS
(
	SELECT Id, Name, Gender, DeptName
	FROM tblEmployee
	JOIN tblDepartment
	ON tblDepartment.DeptId = tblEmployee.DepartmentId
)
UPDATE EmployeesByDepartment SET Gender = 'Male' WHERE Id = 1
--John on tagasi male
SELECT * FROM tblEmployee

---kuvan andmeid niimoodi, et nr asemel on osakonan nimed
---CTE kahe baastabeli pohjal
WITH EmployeesByDepartment
AS
(
	SELECT Id, Name, Gender, DeptName
	FROM tblEmployee
	JOIN tblDepartment
	ON tblDepartment.DeptId = tblEmployee.DepartmentId
)
SELECT * FROM EmployeesByDepartment

---muudame John tagasi maleks
WITH EmployeesByDepartment
AS
(
	SELECT Id, Name, Gender, DeptName
	FROM tblEmployee
	JOIN tblDepartment
	ON tblDepartment.DeptId = tblEmployee.DepartmentId
)
UPDATE EmployeesByDepartment SET Gender = 'Male' WHERE Id = 1

---muudame kahte baastabelit, aga ei saa teha
WITH EmployeesByDepartment
AS
(
	SELECT Id, Name, Gender, DeptName
	FROM tblEmployee
	JOIN tblDepartment
	ON tblDepartment.DeptId = tblEmployee.DepartmentId
)
UPDATE EmployeesByDepartment SET Gender = 'Female', DeptName = 'IT' WHERE Id = 1

---tahame ainult ben-i osakonna nimetust muuta, aga muudab teistel ka ara.
WITH EmployeesByDepartment
AS
(
	SELECT Id, Name, Gender, DeptName
	FROM tblEmployee
	JOIN tblDepartment
	ON tblDepartment.DeptId = tblEmployee.DepartmentId
)
UPDATE EmployeesByDepartment SET DeptName = 'IT' WHERE Id = 1
---kui ainult yhte tabelit, siis on OK, ga mitut tabelit ei saa korraga

---ylesanne 51:recrusive CTE

SELECT * FROM tblEmployee

Create Table tblEmployee
(
  EmployeeId int Primary key,
  Name nvarchar(20),
  ManagerId int
)

Insert into tblEmployee values (1, 'Tom', 2)
Insert into tblEmployee values (2, 'Josh', null)
Insert into tblEmployee values (3, 'Mike', 2)
Insert into tblEmployee values (4, 'John', 3)
Insert into tblEmployee values (5, 'Pam', 1)
Insert into tblEmployee values (6, 'Mary', 3)
Insert into tblEmployee values (7, 'James', 1)
Insert into tblEmployee values (8, 'Sam', 5)
Insert into tblEmployee values (9, 'Simon', 1)

Select Employee.Name as [Employee Name],
IsNull(Manager.Name, 'Super Boss') as [Manager Name]
from tblEmployee Employee
left join tblEmployee Manager
on Employee.ManagerId = Manager.EmployeeId


---koht, kus tabelis on null, sinna pannakse nimi Super Boss
---CTE on ainult ainult paringu ajaks moeldud tabel
With
  EmployeesCTE (EmployeeId, Name, ManagerId, [Level])
  as
  (
    Select EmployeeId, Name, ManagerId, 1
    from tblEmployee
    where ManagerId is null
    
    union all
    
    Select tblEmployee.EmployeeId, tblEmployee.Name, 
    tblEmployee.ManagerId, EmployeesCTE.[Level] + 1
    from tblEmployee
    join EmployeesCTE
    on tblEmployee.ManagerID = EmployeesCTE.EmployeeId
  )
Select EmpCTE.Name as Employee, Isnull(MgrCTE.Name, 'Super Boss') as Manager, 
EmpCTE.[Level] 
from EmployeesCTE EmpCTE
left join EmployeesCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.EmployeeId


---- ylesanne 52 Database normalization

use Sample1

SELECT * FROM tblEmployee

---- 2NF e normal form ja 3NF