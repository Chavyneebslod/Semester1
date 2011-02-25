  import org.omg.CORBA.*;
  import org.omg.CosNaming.*;
  import java.util.Properties.*;
  import java.io.*;
  import Auctioning.*;


  public class Startup {
  
    private static boolean logged = false;
    private static InputStreamReader isr;
    private static BufferedReader in;
  
    public static void main(String[] args) {
     
      try{
          isr = new InputStreamReader(System.in);
          in = new BufferedReader(isr);
          System.out.println("************* Welcome **************");
          while(!logged){
            System.out.println("What method would you like to use?");
            System.out.println("\t1. CORBA");
            System.out.println("\t2. RMI");
            System.out.println("\t3. Nothing, just exit.");
            System.out.print("Make a selection > ");
              String s = in.readLine();
              int selection = 0;
            try{
               selection = Integer.parseInt(s);
            }catch(Exception e){ selection = 42; }
            if(selection == 1)
              useCorba(args);
            else if(selection == 2)
              useRMI();
            else if(selection == 3){
              System.out.println("Bye then!");
              System.exit(0);
            } 
            else
              System.out.println("That was an invalid selection, please try again.");
          }
          System.exit(0);
       }catch(Exception e){   }
     }




    public static void useCorba(String[] args){
      try{
        ORB orb = ORB.init(args, null);         // initialize ORB
        org.omg.CORBA.Object o =
                  orb.resolve_initial_references("NameService");

        // get reference to Deal object
        NamingContext ncRef = NamingContextHelper.narrow(o);
        NameComponent[] nc = new NameComponent[1];
        nc[0]       = new NameComponent();
        nc[0].id    = "Auction";
        nc[0].kind  = "";
        Auction a = AuctionHelper.narrow(ncRef.resolve(nc));
    
        System.out.println("Please enter your username.");
         System.out.print(" > ");
        String uname = in.readLine();
        System.out.println("Please enter your password."); 
         System.out.print(" > ");
        String pass = in.readLine(); 

        String x = a.login(uname, pass);
        System.out.println(x);
        if(x.equals("Success")){
          logged = true;
          auctionclient ac = new auctionclient();
          String[] argx = new String[1];
          argx[0]=uname;
          ac.main(argx);
        }
    }catch(Exception e){System.out.println(e.getMessage());}
 
  }

  public static void useRMI(){}  

} 
