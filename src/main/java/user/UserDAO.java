package user;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    private Connection conn; //데이터베이스에 접근하게 해주는 객체
    private PreparedStatement pstmt;
    private ResultSet rs; //정보를 담을 수 있는 객체

    // 여기서 외부라이브러리 추가 위의 import부분!!
    //Ctrl + Shift + o >  java spl Connection 선택후 Finish
    //자동으로 데이터베이스 커넥션이 이루어질 수 있도록 접속하게해주는 소스

    public UserDAO() { 

 

        try {

 

            String dbURL ="jdbc:mysql://mysql-test-kkl.mysql.database.azure.com:3306/KKL?serverTimezone=UTC&useSSL=false";

 

            //데이터베이스 주소

 

            String dbID = "kkl@mysql-test-kkl";    //데이터베이스 아이디

 

            String dbPassword = "dmb08229@@@@";    //데이터베이스 비밀번호

 

            Class.forName("com.mysql.jdbc.Driver");    // mysql에 접속하는 매개체역할 

 

            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

 

        }catch(Exception e) {

 

            e.printStackTrace(); //오류발생시 오류내용 출력하게 해주는 소스

 

        }

 

    }

 

    //로그인 소스 시작

 

    public int login(String userID, String userPassword) {

 

        String SQL = "Select userPassword From USER where userID = ?";

 

        //실제 SQL에서 작동하게 할 명령문 입력

 

        try {

 

            pstmt = conn.prepareStatement(SQL);

 

            pstmt.setString(1, userID);

 

            //인젝션해킹등을 방지하기 위한 기법 ?에 ID값을 받은 후 사용.

 

            rs = pstmt.executeQuery();

 

            if(rs.next()) {

 

                if(rs.getString(1).equals(userPassword)) {

 

                    return 1; // 로그인 성공

 

                } else 

 

                    return 0; // 비밀번호 불일치

 

            }

 

            return -1; //아이디가 없음

 

        }catch(Exception e) {

 

            e.printStackTrace();    // 예외처리

 

        }

 

        return -2; // 데이터베이스 오류

 

    }

    // 회원가입 소스시작

    public int join(User user) {

        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)"; 

        try {

            pstmt = conn.prepareStatement(SQL);

            pstmt.setString(1, user.getUserID());

            pstmt.setString(2, user.getUserPassword());

            pstmt.setString(3, user.getUserName());

            pstmt.setString(4, user.getUserGender());

            pstmt.setString(5, user.getUserEmail());

            return pstmt.executeUpdate(); //INSERT문의 경우, 반드시 0이상이 반환되므로, -1이외에는 성공적으로 회원가입이 되었다고 볼 수 있다.

        } catch(Exception e) {

            e.printStackTrace();

        }

        return -1; //데이처베이스 오류

    }

 

    

 

}