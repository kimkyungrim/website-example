package bbs;

 

import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.util.ArrayList;

 

public class BbsDAO {

 

    private Connection conn; // 데이터베이스에 접근하게 해주는 객체

    private ResultSet rs; // 정보를 담을 수 있는 객체

 

    // 여기서 외부라이브러리 추가 위의 import부분!!

 

    // Ctrl + Shift + o > java spl Connection 선택후 Finish

 

    // 자동으로 데이터베이스 커넥션이 이루어질 수 있도록 접속하게해주는 소스

 

    public BbsDAO() {

 

        try {

 

            String dbURL = "jdbc:mysql://mysql-test-kkl.mysql.database.azure.com:3306/KKL?serverTimezone=UTC&useSSL=false";

 

            // 데이터베이스 주소

 

            String dbID = "kkl@mysql-test-kkl"; // 데이터베이스 아이디

 

            String dbPassword = "dmb08229@@@@"; // 데이터베이스 비밀번호

 

            Class.forName("com.mysql.jdbc.Driver"); // mysql에 접속하는 매개체역할

 

            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

 

        } catch (Exception e) {

 

            e.printStackTrace(); // 오류발생시 오류내용 출력하게 해주는 소스

 

        }

 

    }

 

    public String getDate() {

        String SQL = "SELECT NOW()"; // 현재시간을 가져오는 SQL구문

        try {

            PreparedStatement pstmt = conn.prepareStatement(SQL); // 연결되어 있는 객체를 이용해서 실행준비단계로 만들어 줌

            rs = pstmt.executeQuery(); // 실행된 결과를 가져오도록 해줌

            if (rs.next()) {

                return rs.getString(1); // 나온값을 반환해 주도록 해줌

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return ""; // 데이터 베이스 오류 알림

    }

 

    public int getNext() {

        String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // bbsID를 새로 생성(+1)하기 위해, 가장 마지막 bbsID를 가져옴

        try {

            PreparedStatement pstmt = conn.prepareStatement(SQL); // 연결되어 있는 객체를 이용해서 실행준비단계로 만들어 줌

            rs = pstmt.executeQuery();

            if (rs.next()) {

                return rs.getInt(1) + 1; // 나온값에 1을 해줘서 새로운 bbsID값을 반환

            }

            return 1; // 기존데이터가 없어 첫번째 게시물인경우

        } catch (Exception e) {

            e.printStackTrace();

        }

        return -1; // 데이터 오류발생 시

    }

    //게시글 작성

    public int write(String bbsTitle, String userID, String bbsContent) {

        String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; // bbs 테이블 안에 6개읜 모든 인자가 들어갈 수 있도록 해줌.

        try {

            PreparedStatement pstmt = conn.prepareStatement(SQL); // 연결되어 있는 객체를 이용해서 실행준비단계로 만들어 줌

            pstmt.setInt(1, getNext());

            pstmt.setString(2, bbsTitle);

            pstmt.setString(3, userID);

            pstmt.setString(4, getDate());

            pstmt.setString(5, bbsContent);

            pstmt.setInt(6, 1);

            return pstmt.executeUpdate();

 

        } catch (Exception e) {

            e.printStackTrace();

        }

        return -1; // 데이터 오류발생 시

    }

 

    public ArrayList<Bbs> getList(int pageNumber) { // Ctrl + Shift + o 눌러서 import시켜줌

        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";

        // bbsID가 특정숫자(위의 물음표부분)보다 작을때, bbsAvailable이 1인(삭제되지 않은 게시글)을 내림차순 정렬로, 10개까지

        ArrayList<Bbs> list = new ArrayList<Bbs>();

        try {

            PreparedStatement pstmt = conn.prepareStatement(SQL); // 연결되어 있는 객체를 이용해서 실행준비단계로 만들어 줌

            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // 게시글 10개에 페이지 1개씩 할당하기 위한 함수

            rs = pstmt.executeQuery();

            while (rs.next()) {

                Bbs bbs = new Bbs();

                bbs.setBbsID(rs.getInt(1));

                bbs.setBbsTitle(rs.getString(2));

                bbs.setUserID(rs.getString(3));

                bbs.setBbsDate(rs.getString(4));

                bbs.setBbsContent(rs.getString(5));

                bbs.setBbsAvailable(rs.getInt(6));

                list.add(bbs); // list에 해당값을 담아서 반환

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list; // 리스트 출력

    }

    //게시글 페이지 설명

    public boolean nextPage(int pageNumber) { //게시글이 10개에 따른 페이지 설정을 위한 함수

        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";

        try {

            PreparedStatement pstmt = conn.prepareStatement(SQL); // 연결되어 있는 객체를 이용해서 실행준비단계로 만들어 줌

            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // 게시글 10개에 페이지 1개씩 할당하기 위한 함수

            rs = pstmt.executeQuery();

            if (rs.next()) {

                return true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    //게시글 불러오기

    public Bbs getBbs(int bbsID) {

        String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; //?값에 해당하는 게시글을 가져옴

        try {

            PreparedStatement pstmt = conn.prepareStatement(SQL); // 연결되어 있는 객체를 이용해서 실행준비단계로 만들어 줌

            pstmt.setInt(1, bbsID);

            rs = pstmt.executeQuery();

            if (rs.next()) { //결과가 나왔다면 아래의 항목에 맞게 불러옴.

                Bbs bbs = new Bbs();

                bbs.setBbsID(rs.getInt(1));

                bbs.setBbsTitle(rs.getString(2));

                bbs.setUserID(rs.getString(3));

                bbs.setBbsDate(rs.getString(4));

                bbs.setBbsContent(rs.getString(5));

                bbs.setBbsAvailable(rs.getInt(6));

                return bbs; // 나온 값을 bbs로 반환

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return null; //없다면 null반환

    }

    //게시글 수정

    public int update(int bbsID, String bbsTitle, String bbsContent) {

            String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?"; // 특정 ID의 제목과 내용을 바꿔줌

            try {

                PreparedStatement pstmt = conn.prepareStatement(SQL); // 연결되어 있는 객체를 이용해서 실행준비단계로 만들어 줌

                pstmt.setString(1, bbsTitle);

                pstmt.setString(2, bbsContent);

                pstmt.setInt(3, bbsID);

                return pstmt.executeUpdate();

 

            } catch (Exception e) {

                e.printStackTrace();

            }

            return -1; // 데이터 오류발생 시

    }

    //게시글 삭제

    public int delete(int bbsID) {

        String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; // 글삭제 후에도, 값은 남아있도록 Available값만 0으로

        try {

            PreparedStatement pstmt = conn.prepareStatement(SQL); // 연결되어 있는 객체를 이용해서 실행준비단계로 만들어 줌

            pstmt.setInt(1, bbsID);

            return pstmt.executeUpdate();

 

        } catch (Exception e) {

            e.printStackTrace();

        }

        return -1; // 데이터 오류발생 시

    }

}