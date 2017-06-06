package DB;

import Information.DBI;
import java.sql.*;
import Error.*;

public class DBManager {
	private DBI dbInf;
	private Connection conn;

	public DBManager() {

	}

	public DBManager(DBI dbInf) {
		this.dbInf = dbInf;
	}


	public Connection getConnection() {
		if (conn == null) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(dbInf.getUrl(),dbInf.getId(),dbInf.getPwd());
			} catch (Exception e) {
				ErrorJsp error = new ErrorJsp(e, DBManager.class, "getConnection");
			}
		}

		return conn;
	}

	public void disConnect() {
		try {
			if (conn.isClosed()) {
				return;
			} else {
				conn.close();
			}
		} catch (Exception e) {
			ErrorJsp error = new ErrorJsp(e, DBManager.class, "disConnect");
		}
	}
}
