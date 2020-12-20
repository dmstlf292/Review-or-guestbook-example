package review2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import guestbook.GuestBookBean;

public class GuestBookMgr {
	
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE= new SimpleDateFormat("yyyy'년' M'월' d'일' (E)");
	private final SimpleDateFormat SDF_TIME=new SimpleDateFormat("H:mm:ss");
	public GuestBookMgr() {
		pool=DBConnectionMgr.getInstance();//여기 공부하기, 회원 탈퇴때 본거 같음
	}
	//Join Login
	public boolean loginJoin(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select*from tblJoin where id=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			if(pstmt.executeQuery().next()) //여기주의
				flag=true;//여기주의
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
		
	}
	//Join Information
	public JoinBean getJoin(String id) {//bean 가져 오는 것!!!
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		JoinBean bean = new JoinBean();
		try {
			con = pool.getConnection();
			sql = "select*from tblJoin where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(rs.getString(1));
				bean.setPwd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setEmail(rs.getString(4));
				bean.setId(rs.getString(5));
				bean.setHp(rs.getString(6));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//GuestBook Insert
	public void insertGuestBook(GuestBookBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblGuestBook(id,contents,ip,grade,regtime,secret values(?,?,?,now(),now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getContents());
			pstmt.setString(3, bean.getIp());
			pstmt.setString(4, bean.getSecret());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		//return; 여기서 리턴 안하네...? 왜?
	}
	
	//GuestBook List
	public Vector<GuestBookBean> listGuestBook(String id, String grade){//vector로 가져오기
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<GuestBookBean> vlist=new Vector<GuestBookBean>();
		try {
			con = pool.getConnection();
			if(grade.equals("1")) {
			sql = "select*from tblGuestBook order by num desc";
			pstmt = con.prepareStatement(sql);
			} else if(grade.equals("0")) {
			sql = "select*from tblGuestBook where id=? or secret='0' order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				GuestBookBean bean = new GuestBookBean();
				bean.setNum(rs.getInt("num"));
				bean.setId(rs.getString("id"));
				bean.setContents(rs.getString("contents"));
				bean.setIp(rs.getString("ip"));
				
				String tempDate=SDF_DATE.format(rs.getDate("regDate"));
				bean.setRegdate(tempDate);
				
				String tempTime=SDF_TIME.format(rs.getDate("regTime"));
				bean.setRegtime(tempTime);
				
				bean.setSecret(rs.getString("secret"));
				vlist.addElement(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//GuestBook Read : 날짜와 시간은 list 동일하게
	public GuestBookBean getGuestBook(int num) {//GuestBookBean 이용하기
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		GuestBookBean bean = new GuestBookBean();
		try {
			con = pool.getConnection();
			sql = "select*from tblGuestBook where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);//기본값
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setId(rs.getString("id"));
				bean.setContents(rs.getString("contents"));
				bean.setIp(rs.getString("ip"));
				String tempDate = SDF_DATE.format(rs.getDate("regDate"));
				bean.setRegdate(tempDate);
				String tempTime = SDF_TIME.format(rs.getTime("regTime"));
				bean.setRegtime(tempTime);
				bean.setSecret(rs.getString("secret"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//GuestBook Update 수정 : Contents, ip, secret
	public void updateGuestBook(GuestBookBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblGuestBook set contents=?, ip=?, secret=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getContents());
			pstmt.setString(2, bean.getIp());
			pstmt.setString(3, bean.getSecret());
			pstmt.setInt(4, bean.getNum());
		    pstmt.executeUpdate();//여기 주의

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		//return; 여기서 리턴 안하네...? 왜?
	}
	
	//GuestBook Delete 삭제
	
	public void deleteGuestBook(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblGuestBook where num= ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
		    pstmt.executeUpdate();//여기 주의

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		//return; 여기서 리턴 안하네...? 왜?
	}
	
	
	
	
	
	
	
	
/////댓글 Comment 기능 4가지/////////// 
    //Comment Insert////db2 사용
	public void insertComment (CommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblComment(num,cid,comment,cip,cregDate values (?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getCid());
			pstmt.setString(3, bean.getComment());
			pstmt.setString(4, bean.getCip());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//Comment List////db1 사용
	public Vector<CommentBean> listComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommentBean> vlist=new Vector<CommentBean>();
		try {
			con = pool.getConnection();
			sql = "select*from tblComment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setCnum(rs.getInt("cnum"));
				bean.setNum(rs.getInt("num"));
				bean.setCid(rs.getString("cid"));
				bean.setComment(rs.getString("comment"));
				bean.setCip(rs.getString("cip"));
				String tempDate=SDF_DATE.format(rs.getDate("cregDate"));
				bean.setCregDate(tempDate);
				vlist.addElement(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	//Comment Delete : 댓글 삭제//// db2 사용
	public void deleteComment (int cnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblComment where cnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//Comment All Delete : 방명록 글 삭제시 관련된 댓글 모두 삭제 ////
	public void deleteAllComment (int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblComment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
		    pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
}



























