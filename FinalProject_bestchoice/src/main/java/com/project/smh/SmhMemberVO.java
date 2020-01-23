package com.project.smh;

public class SmhMemberVO {

private int member_idx;            // 회원번호(시퀀스로 데이터가 들어온다)
private String email;              // 이메일   
private String pwd;                // 비밀번호 (SHA-256 암호화 대상  단방향암호화)
private String name;               // 회원명
private String nickname;          // 닉네임
private String hp1;                // 휴대폰
private String hp2;                  //       (AES-256 암호화/복호화 대상    양방향암호화)
private String hp3;                  //       (AES-256 암호화/복호화 대상    양방향암호화)
private String gender;            // 성별     남자 : 1 / 여자 : 2
private String birthday;          //  생년월일 
private int    mstatus;             // 회원탈퇴유무   1:사용가능(가입중) / 0:사용불능(탈퇴) 
private String registerday;        // 가입일자
private String lastLoginDate;      // 마지막으로 로그인 한 날짜시간 기록용
private String lastpwdChangeDate;  // 마지막으로 암호를 변경한 날짜시간 기록용

private boolean requirePwdChange = false; 
// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 6개월이 지났으면 true
// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 6개월이 지나지 않았으면 false 

/////////////////////////////////////////////////////////////////// 추가 
private String age;

   public String getAge() {
      return age;
   }
   
   public void setAge(String age) {
      this.age = age;
   }
   
   public String getAllHp() {
      return hp1+"-"+hp2+"-"+hp3;
   }

private int totalPrice;
private int totalCount;



   public int getTotalPrice() {
      return totalPrice;
   }
   
   public void setTotalPrice(int totalPrice) {
      this.totalPrice = totalPrice;
   }
   
   public int getTotalCount() {
      return totalCount;
   }
   
   public void setTotalCount(int totalCount) {
      this.totalCount = totalCount;
   }

/////////////////////////////////////////////////////////////////// 추가 


   public int getMember_idx() {
      return member_idx;
   }
   
   public SmhMemberVO() {}
   
   public SmhMemberVO(int member_idx, String email, String pwd, String name, String nickname, String hp1, String hp2,
         String hp3, String gender, String birthday, int mstatus, String registerday,
         String lastLoginDate, String lastpwdChangeDate, boolean requirePwdChange, String age, int totalPrice ,int totalCount) {
      super();                                  /////////////////////////////////////////////////////////////////// 추가 
      this.member_idx = member_idx;
      this.email = email;
      this.pwd = pwd;
      this.name = name;
      this.nickname = nickname;
      this.hp1 = hp1;
      this.hp2 = hp2;
      this.hp3 = hp3;
      this.gender = gender;
      this.birthday = birthday;
      this.mstatus = mstatus;      
      this.registerday = registerday;
      this.lastLoginDate = lastLoginDate;
      this.lastpwdChangeDate = lastpwdChangeDate;
      this.requirePwdChange = requirePwdChange;
        /////////////////////////////////////////////////////////////////// 추가 
      this.age = age;
      this.totalPrice = totalPrice;
      this.totalCount = totalCount;
   }

   public void setMember_idx(int member_idx) {
      this.member_idx = member_idx;
   }
   
   public String getEmail() {
      return email;
   }
   
   public void setEmail(String email) {
      this.email = email;
   }
   
   public String getPwd() {
      return pwd;
   }
   
   public void setPwd(String pwd) {
      this.pwd = pwd;
   }
   
   public String getName() {
      return name;
   }
   
   public void setName(String name) {
      this.name = name;
   }
   
   public String getNickname() {
      return nickname;
   }
   
   public void setNickname(String nickname) {
      this.nickname = nickname;
   }
   
   public String getHp1() {
      return hp1;
   }
   
   public void setHp1(String hp1) {
      this.hp1 = hp1;
   }
   
   public String getHp2() {
      return hp2;
   }
   
   public void setHp2(String hp2) {
      this.hp2 = hp2;
   }
   
   public String getHp3() {
      return hp3;
   }
   
   public void setHp3(String hp3) {
      this.hp3 = hp3;
   }
   
   public String getGender() {
      return gender;
   }
   
   public void setGender(String gender) {
      this.gender = gender;
   }
   
   public String getBirthday() {
      return birthday;
   }
   
   public void setBirthday(String birthday) {
      this.birthday = birthday;
   }
   
   public int getmstatus() {
      return mstatus;
   }
   
   public void setmstatus(int mstatus) {
      this.mstatus = mstatus;
   }
   
   
   
   public String getRegisterday() {
      return registerday;
   }
   
   public void setRegisterday(String registerday) {
      this.registerday = registerday;
   }
   
   public String getLastLoginDate() {
      return lastLoginDate;
   }
   
   public void setLastLoginDate(String lastLoginDate) {
      this.lastLoginDate = lastLoginDate;
   }
   
   public String getLastpwdChangeDate() {
      return lastpwdChangeDate;
   }
   
   public void setLastpwdChangeDate(String lastpwdChangeDate) {
      this.lastpwdChangeDate = lastpwdChangeDate;
   }
   
   public boolean isRequirePwdChange() {
      return requirePwdChange;
   }
   
   public void setRequirePwdChange(boolean requirePwdChange) {
      this.requirePwdChange = requirePwdChange;
   }


}