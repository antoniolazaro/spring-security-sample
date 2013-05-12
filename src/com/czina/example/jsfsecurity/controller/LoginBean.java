package com.czina.example.jsfsecurity.controller;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.RememberMeServices;

/**
 * The Class LoginBean.
 */
@ManagedBean(name = "loginMgmtBean")
@RequestScoped
public class LoginBean {
 
    /** The user name. */
    private String userName = null;
 
    /** The password. */
    private String password = null;
 
    /** The remember me. */
    private String rememberMe = null;
 
    /** The authentication manager. */
    @ManagedProperty(value = "#{authenticationManager}")
    private AuthenticationManager authenticationManager = null;
 
    /** The remember me services. */
    @ManagedProperty(value = "#{rememberMeServices}")
    private RememberMeServices rememberMeServices = null;
 
    @ManagedProperty(value="#{userDetailsService}")
    private UserDetailsService userDetailsService = null;
    /**
     * Login.
     *
     * @return the string
     */
    public String login() {
        try {
            Authentication result = null;
            if ("TRUE".equalsIgnoreCase(this.getRememberMe())) {
                UserDetails userDetails = userDetailsService.loadUserByUsername(getUserName());
                RememberMeAuthenticationToken rememberMeAuthenticationToken = new RememberMeAuthenticationToken(
                        "jsfspring-sec", userDetails,
                        userDetails.getAuthorities());
                HttpServletRequest httpServletRequest = (HttpServletRequest)FacesContext.getCurrentInstance().getExternalContext().getRequest();
                HttpServletResponse httpServletResponse = (HttpServletResponse) FacesContext.getCurrentInstance().getExternalContext().getResponse();
                rememberMeServices.loginSuccess(httpServletRequest, httpServletResponse, rememberMeAuthenticationToken);
                result = rememberMeAuthenticationToken;
            } else {
                Authentication request = new UsernamePasswordAuthenticationToken(
                        this.getUserName(), this.getPassword());
                result = authenticationManager.authenticate(request);
            }
            SecurityContextHolder.getContext().setAuthentication(result);
        } catch (AuthenticationException e) {
            e.printStackTrace();
            FacesContext.getCurrentInstance().addMessage(null,new FacesMessage("Login e senha inválidos"));
            return null;
        }
        return "secured";
    }
 
    /**
     * Cancel.
     *
     * @return the string
     */
    public String cancel() {
        return null;
    }
 
    /**
     * Logout.
     *
     * @return the string
     */
    public String logout() {
        SecurityContextHolder.clearContext();
        /**
         * Delete Cookies
         */
        HttpServletRequest httpServletRequest = (HttpServletRequest)FacesContext.getCurrentInstance().getExternalContext().getRequest();
        HttpServletResponse httpServletResponse = (HttpServletResponse) FacesContext.getCurrentInstance().getExternalContext().getResponse();
        Cookie cookie = new Cookie("SPRING_SECURITY_REMEMBER_ME_COOKIE", null);
        cookie.setMaxAge(0);
        cookie.setPath(httpServletRequest.getContextPath().length() > 0 ? httpServletRequest.getContextPath() : "/");
        httpServletResponse.addCookie(cookie);
        return "loggedout";
    }
 
    /**
     * Gets the user name.
     *
     * @return the user name
     */
    public String getUserName() {
        return userName;
    }
 
    /**
     * Sets the user name.
     *
     * @param userName
     *            the new user name
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }
 
    /**
     * Gets the password.
     *
     * @return the password
     */
    public String getPassword() {
        return password;
    }
 
    /**
     * Sets the password.
     *
     * @param password
     *            the new password
     */
    public void setPassword(String password) {
        this.password = password;
    }
 
    /**
     * Gets the remember me.
     *
     * @return the remember me
     */
    public String getRememberMe() {
        return rememberMe;
    }
 
    /**
     * Sets the remember me.
     *
     * @param rememberMe
     *            the new remember me
     */
    public void setRememberMe(String rememberMe) {
        this.rememberMe = rememberMe;
    }
 
    /**
     * Gets the authentication manager.
     *
     * @return the authentication manager
     */
    public AuthenticationManager getAuthenticationManager() {
        return authenticationManager;
    }
 
    /**
     * Sets the authentication manager.
     *
     * @param authenticationManager
     *            the new authentication manager
     */
    public void setAuthenticationManager(
            AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
    }
 
    /**
     * Gets the remember me services.
     *
     * @return the remember me services
     */
    public RememberMeServices getRememberMeServices() {
        return rememberMeServices;
    }
 
    /**
     * Sets the remember me services.
     *
     * @param rememberMeServices
     *            the new remember me services
     */
    public void setRememberMeServices(RememberMeServices rememberMeServices) {
        this.rememberMeServices = rememberMeServices;
    }
 
    public UserDetailsService getUserDetailsService() {
        return userDetailsService;
    }
 
    public void setUserDetailsService(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }
}