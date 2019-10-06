# project-intro
This is a boilerplate for company
## Total of project   8
- [Planing project] 2
- [Doing project] 2
- [Maintain project] 3
- [Finish project] 1

## Table of content Of project [xx]

- [Installation](#installation)
    - [OS](#os)
    - [Tools](#tools)
    - [Environment](#environment)
- [Architecture](#architect)
    - [Overview](#overview)
- [Deploy setup](#deploy)
    - [Extension](#extension)
    - [Database](#database)
    - [LDAP](#database)
- [Repo Git,SVN](#page-setup)
    - [client](#client)
    - [server](#server)
    - [other repo](#other repo)
- [Requirements](#requirements)
    - [server](#server)
- [Contact person](#contact)
    - [Project manager](#project)
- [Design](#design)
    - [web](#web)
    - [mobile](#mobile)
- [Account](#Account)
    - [IOS](#ios)
    - [android](#ios)
    - [server](#ios)
- [Account JIRA, Redmine](#links)
- [Test, staging, production server](#links)
- [Rule](#links)
- [Training](#links)
    - [For Beginer](#beginer)
    - [For Junior](#beginer)
- [Other](#links)
- [License](#links)
- [Links reference](#links)
- [BoilderPlate](#links)

Khi làm việc mà khách hàng không share thông tin gì vì lý do gì đó (cái này thì thi thoảng)
1 developer cần làm được việc khi
 - có cái để so sánh (và cần so sánh được)
 - có môi trường làm việc giống nhau hoặc 1 server testing hoặc staging có thể truy cập được để kiểm tra
 
 Vì lý do trên nên khó thực hiện tốt khi thiếu dữ liệu và môi trường khách hàng đã cài đặt
 
 chúng ta dùng thủ thuật sau với trường hợp thiếu db sample
 1. hãy xin quyền admin của site liferay
 2. truy cập vào site với quyền admin chuyển sang tab Control panel -> Configuration -> Server admin --> groovy
 3. hãy dùng script sau để lấy backupdb
   với trường hợp db lớn ta phải thực hiện back up từng table
   nhưng câu lệnh chung như thế này

def sout = new StringBuilder(), serr = new StringBuilder()
def proc = 'mysqldump -hlocalhost -u root -proot liferay -C --result-file=/usr/liferay/liferay-ce-portal-7.0-ga7/liferay.txt'.execute()
proc.consumeProcessOutput(sout, serr)
proc.waitForOrKill(10000)
println "out>"
println "$sout"
println "err>"
println "$serr"

đến đây ta có output của db backup để sử dụng

4. có thể đọc lại file
try {
	java.io.File file = new java.io.File("/usr/liferay/liferay-ce-portal-7.0-ga7/liferay.txt");
	String s = com.liferay.portal.kernel.util.FileUtil.read(file);
	out.println(s);
} catch (Exception e) {
	out.println(e.getMessage());
}

5. reference : https://www.cvedetails.com/vulnerability-list/vendor_id-2114/Liferay.html
   
