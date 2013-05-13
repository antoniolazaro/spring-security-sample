package com.czina.example.jsfsecurity.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * The Class DBPasswordEncrypterBean.
 * @author prabhat.jha
 */
public class DBPasswordEncrypterBean extends JdbcDaoSupport{
     
    /** The Constant selectQuery. */
    private String selectQuery = null;
     
    /** The Constant updateQuery. */
    private String updateQuery = null;
     
    /** The password encoder. */
    private PasswordEncoder passwordEncoder = null;
    
    /** The user details service. */
    private UserDetailsService userDetailsService = null;
 
    /**
     * Encrypt db password.
     */
    public void encryptDBPassword(){
        getJdbcTemplate().query(getSelectQuery(), new RowCallbackHandler() {
            @Override
            public void processRow(ResultSet rs) throws SQLException {
            	try{
                final String username = rs.getString("username");
                System.out.println("username -> "+username);
                UserDetails user = userDetailsService.loadUserByUsername(username);
                System.out.println("user -> "+user);
                String password = rs.getString("password");
                System.out.println("vai encriptar -> "+password);
                final String encryptedPassword = passwordEncoder.encode(password);

                System.out.println("encriptou -> "+passwordEncoder);
                getJdbcTemplate().update(getUpdateQuery(),encryptedPassword,username);
                }catch(SQLException ex){
                	ex.printStackTrace();
                }
            }
        });
    }
     
    /**
     * Gets the password encoder.
     * 
     * @return the password encoder
     */
    public PasswordEncoder getPasswordEncoder() {
        return passwordEncoder;
    }
 
    /**
     * Sets the password encoder.
     * 
     * @param passwordEncoder
     *            the new password encoder
     */
    public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }
 
    /**
     * Gets the select query.
     * 
     * @return the select query
     */
    public String getSelectQuery() {
        return selectQuery;
    }
 
    /**
     * Sets the select query.
     * 
     * @param selectQuery
     *            the new select query
     */
    public void setSelectQuery(String selectQuery) {
        this.selectQuery = selectQuery;
    }
 
    /**
     * Gets the update query.
     * 
     * @return the update query
     */
    public String getUpdateQuery() {
        return updateQuery;
    }
 
    /**
     * Sets the update query.
     * 
     * @param updateQuery
     *            the new update query
     */
    public void setUpdateQuery(String updateQuery) {
        this.updateQuery = updateQuery;
    }
    
    public UserDetailsService getUserDetailsService() {
		return userDetailsService;
	}

	public void setUserDetailsService(UserDetailsService userDetailsService) {
		this.userDetailsService = userDetailsService;
	}
}