# LogGatherer
학습용 로그 수집 서브시스템 

1. Windows 계정에 로그온하면 FileAccessMonitor 실행됩니다.
2. 이 상태로 프로그램을 켜면 프로세스에 dll injection을 실행하고,   
해당 프로그램에서 발생한 파일 접근 기록을 D:\log.txt에 로깅합니다.
3. 매일 오전 0시에 account.txt에 설정된 서버로 해당 로그를 전송합니다.

### 설치
- 압축 해제 후 setup.bat을 관리자 권한으로 실행

### 로그 전송 서버 설정
1. 계정 정보:		account.txt 파일에 직접 작성 (예시 파일 확인)
2. ssh 인증키 경로:	%HOMEDRIVE%%HOMEPATH%\.ssh\id_rsa 파일

### 로그 전송 시각
- 매일 오전 0시 정각 (setup.bat 파일이나 taskschd에서 직접 수정)

### 프로모션 영상
[![학습용 로그 수집 서브시스템 설치 영상](https://i9.ytimg.com/vi/3Tyo85Gf3Yo/mq2.jpg?sqp=CLj69P8F&rs=AOn4CLAVodshwRBxfe_nMEQPpb7FkAHKHg)](https://www.youtube.com/watch?v=3Tyo85Gf3Yo)
