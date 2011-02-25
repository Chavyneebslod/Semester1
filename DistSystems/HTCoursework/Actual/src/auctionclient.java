  import org.omg.CORBA.*;
  import org.omg.CosNaming.*;
  import java.util.*;
  import java.io.*;
  import Auctioning.*;

  public class auctionclient {
 
    private static String loggedUser;
    private static Auction a;
    private static org.omg.CORBA.Object o; 
    private static InputStreamReader isr;
    private static BufferedReader in;

    public static void main(String[] args) {
      loggedUser=args[0];
      try {
        ORB orb = ORB.init(args, null);         // initialize ORB
        o = orb.resolve_initial_references("NameService");

        // get reference to Deal object
        NamingContext ncRef = NamingContextHelper.narrow(o);
        NameComponent[] nc = new NameComponent[1];
        nc[0]       = new NameComponent();
        nc[0].id    = "Auction";
        nc[0].kind  = "";
        a = AuctionHelper.narrow(ncRef.resolve(nc));

        isr = new InputStreamReader(System.in);
        in = new BufferedReader(isr);
        int sel=0;
        System.out.println("******* You have logged in Successfully! ********");
        while(sel ==0){  
          System.out.println("Please make a selection");
          System.out.println("\t1. Get all the listed auctions");
          System.out.println("\t2. List a new item for auction.");
          System.out.println("\t3. Lookup an auction.");
          System.out.println("\t4. Place a bid on an auction.");
          System.out.println("\t5. Logout.");
          System.out.print("Please make your selection > "); 
          String f = in.readLine();
          try{
            sel = Integer.parseInt(f);
          }catch(Exception e){ sel = 42; }
          switch(sel){
            case 1: allItems(); sel=0;  break; 
            case 2: newAuction(); sel=0; break;
            case 3: System.out.println("Stub"); sel=0; break;
            case 4: placeBid(); sel=0; break;
            case 5: a.logout(loggedUser); System.out.println("BYE!"); System.exit(0);
            default: System.out.println("You have not made a valid selection, please try again."); sel=0; break;
          }
        }        
      } catch (Exception e) {
        System.out.println("ERROR : " + e);
        e.printStackTrace(System.out);
      }
    }

    private static void newAuction(){
      boolean correct = false;
      String iName= "";
      String  iDesc = "";
      while(!correct){
        try{
          System.out.print("Please enter the items name > ");
          iName = in.readLine();
          System.out.print("Please enter a description > ");
          iDesc = in.readLine();
          correct = true;  
        }catch(Exception e){}
      }
      double minBid = 0;
      try{
        System.out.print("Please enter a minimum bid > ");
        minBid = Double.parseDouble(in.readLine());
      }catch(Exception e){
        System.out.println("Minimum bid has defaulted to 0.");
      }
      int days = 0;
      int hours = 0;
      int mins = 0;
      boolean correct2 = false;
      try{
        while(!correct2 && days>=0 && hours>=0 && mins>=0){
          System.out.print("Please enter the number of days that the Auction is running for > ");
          days = Integer.parseInt(in.readLine());
          System.out.print("Please enter the number of hours in that day > ");
          hours = Integer.parseInt(in.readLine());
          System.out.print("Please enter the number of minutes in that hour > ");
          mins = Integer.parseInt(in.readLine());
          correct2 = true;
        }
      }catch(Exception e){}
      long tte = days*86400000 + hours*3600000 + mins*60000;
      Calendar cal = Calendar.getInstance();
      Date d = cal.getTime();
      tte = tte +  d.getTime();
      Random r = new Random();
      int rnum = (int)tte % r.nextInt(9999);
      String iRef = loggedUser.substring(loggedUser.length()/2) + rnum;   
      a.addItem( new b(iRef, loggedUser, iName, iDesc, minBid, tte, 0.0, ""));
    }
     

 
    private static void allItems(){
      b[] bArray = a.getAllItems();
      System.out.println("******** All Current Auctions ********"); 
      for(int i=0;i<bArray.length; i++){
        System.out.println("***********************************");
        System.out.print("ItemRef: "+bArray[i].itemRef+"\n\tItem Name: "+bArray[i].itemName+"\n\tPosted by: "+bArray[i].poster+"\n\tItem Description: "+bArray[i].itemDesc+"\n\tMinimum Bid: "+bArray[i].minBid+"\n\tWinning Bidder: "+bArray[i].winningBidder+"\n\t  Winning Bid: "+bArray[i].winningBid+"\n\tTime Remaining: ");
        long endMills = bArray[i].endTime;
        Calendar cal = Calendar.getInstance();
        Date now = cal.getTime();
        long nowMills = now.getTime();
        long time_remaining =  endMills - nowMills;
        if(time_remaining > 0){
          long tRSeconds = time_remaining/1000;
          long tRMins = tRSeconds/60;
          long tRHours = tRMins/60;
          long tRDays = tRHours/24;

          int hoursLeft = (int)tRHours % 24; 
          int minsLeft = (int)tRMins % 60;
          int secsLeft = (int)tRSeconds % 60;
        
          System.out.println(tRDays+" Days, "+hoursLeft+" Hours, "+minsLeft+" Minutes, "+secsLeft+" Seconds.\n");
        }else
          System.out.println("Finished\n");
      } 
    }

    private static void placeBid(){
      String ir = getRef();
      double bid = 0;
      boolean correct = false;
      if(!ir.equals("cancel")){
        while(!correct){
          try{
            System.out.print("Please enter your bid in £ > ");
            String x = in.readLine();
            bid = Double.parseDouble(x);
            correct = true;
          }catch(Exception e){ System.out.println("That's not correct"); }  
        }
        System.out.println(a.placeBid(ir, loggedUser, bid));
      }
    }


    private static String getRef(){
      boolean correct = false;
      b[] bArray = a.getAllItems();
      String candidate = "";   
      while(!correct){
        System.out.println("Please enter the reference code of the item you want to place a bid on.");
        System.out.print("Or type 'cancel' to cancel > ");
        try{
          candidate = in.readLine();
        }catch(Exception e){}
        if(!candidate.equals("cancel")){ 
          for(int i=0;i<bArray.length;i++){
            if(bArray[i].itemRef.equals(candidate)){
              return candidate;
            }
          }
        }else{
          return "cancel";
        } 
      }
      return "cancel"; 
    }
  }
