  import java.io.*;
  import java.util.*;
  import Auctioning.*;

  public class AuctionImpl extends AuctionPOA {
    private Vector v;
    private String[][] users;


    public AuctionImpl() {
      v = new Vector();
      users =  new String[3][3];
      users[0][0] = "Joe";
      users[0][1] = "Joe";
      users[0][2] = "No";
      users[1][0] = "peter";
      users[1][1] = "peter";
      users[1][2] = "No";
      users[2][0] = "elliot";
      users[2][1] = "elliot";
      users[2][2] = "No";
    }

    public void addItem(b B){ v.addElement(B); }
    public b[] getAllItems(){
      b[] bs = new b[v.size()];
      for (int i=0; i<v.size(); i++)
        bs[i] =(b)v.elementAt(i);
      return bs;  
    }

    public b getItem( String itemRe){
      b candidateb;
      b foundb = null;
      for(int i=0;i<v.size();i++){
        candidateb = (b)v.elementAt(i);
        if(candidateb.itemRef.equals(itemRe)){
          foundb = (b)v.elementAt(i);
          break;
        }
      }
      return foundb;  
    }

    public String placeBid(String itemRe, String poster, double bid){
      b candidateb;
      b foundb = null;
      int savedI;
      for(int i=0;i<v.size();i++){
        candidateb = (b)v.elementAt(i);
        if(candidateb.itemRef.equals(itemRe)){
          foundb = (b)v.elementAt(i);
          savedI =i;
          break;
        }
      }
      long endMills = foundb.endTime;
      Calendar cal = Calendar.getInstance();
      Date now = cal.getTime();
      long nowMills = now.getTime();
      long time_remaining =  endMills - nowMills;
      if(time_remaining> 0){
        if(foundb.winningBid < bid && foundb.minBid < bid){
          foundb.winningBid = bid;
          foundb.winningBidder = poster;
          return "Bid Sucessfully Placed.";
        }else
          return "Bid Failed.";
      }
      return "Bid Failed.";
    }

    public String login(String uname, String pass){
      for(int i =0; i<3;i++){
        if(users[i][0].equals(uname) && users[i][1].equals(pass)){
          if(users[i][2].equals("No")){
            users[i][2] ="Yes";
            return "Success";
          }else
           return "You're already logged in!";
        }
      }
      return "Incorrect Username or Password.";
    }

    public void logout(String uname){
      for(int i =0; i<3;i++){
        if(users[i][0].equals(uname))
          users[i][2] = "No";
      }
    }


  }
