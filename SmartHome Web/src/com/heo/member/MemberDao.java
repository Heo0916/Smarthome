package com.heo.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.heo.member.MemberDao;
import com.heo.member.MemberDto;

import SHA256Util.SHA256Util;

public class MemberDao {
	public static final int MEMBER_NONEXISTENT = 0;
	public static final int MEMBER_EXISTENT = 1;
	public static final int MEMBER_JOIN_FAIL = 0;
	public static final int MEMBER_JOIN_SUCCESS = 1; 
	public static final int MEMBER_LOGIN_PW_NO_GOOD = 0;
	public static final int MEMBER_LOGIN_SUCCESS = 1;
	public static final int MEMBER_LOGIN_IS_NOT = 0;	
	
	private static MemberDao instance = new MemberDao();

	public MemberDao(){ // 생성자
	}
	public static MemberDao getInstance(){
		return instance;
	}
	
	private Connection getConnection() {
		Context context = null;
		DataSource ds = null;
		Connection con = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mariadb://10.100.111.84:3306/home","root","1234");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return con;		
	}
	
	public int join(MemberDto dto) {
		int ri = 0;			Connection con = null;		PreparedStatement pstmt = null;
		String query = "INSERT into user values (?,?,?,?)";
		String newPassword = SHA256Util.getEncrypt(dto.getUserPassword(), dto.getUserID());
		try {
			con = getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, dto.getUserID());
			pstmt.setString(2, newPassword);
			pstmt.setString(3, dto.getUserName());
			pstmt.setString(4, dto.getUserEmail());
			pstmt.executeUpdate();
			
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return -1; // db오류
	}
	
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 복호화된 패스워드
        String newPassword = SHA256Util.getEncrypt(userPassword, userID);
        
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(newPassword))
					return 1; // 로그인 성공
				else 
					return 0; // 비밀번호 불일치
				}
				return -1;
			}
			catch (Exception e) {
			e.printStackTrace();
		} 
			return -2; // db오류
		}
	
	public int confirmID(String userid) {
		int result = -1;
		String sql = "select userid from member_sha where userid=?";
		// String sql2 = "select userid from member_sha where userid="+userid;
		Connection conn = null;
		PreparedStatement pre = null;
		ResultSet rs = null;			
		try {
			conn = getConnection();
			pre = conn.prepareStatement(sql);
			pre.setString(1, userid);
			rs = pre.executeQuery();
			//rs = pre.executeQuery(sql2);
			if (rs.next()) {
				result =1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {			
				try {
					if (rs!=null) rs.close();
					if (pre!=null) pre.close();
					if (conn!=null) conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}			
		}
		return result;		
	}
	
	

	
	
	
}


