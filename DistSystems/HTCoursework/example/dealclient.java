  import org.omg.CORBA.*;
  import org.omg.CosNaming.*;
  import java.util.Properties.*;
  import java.io.*;
  import Dealing.*;

  public class dealclient {
    public static void main(String[] args) {
      try {
        ORB orb = ORB.init(args, null);         // initialize ORB
        org.omg.CORBA.Object o = 
                  orb.resolve_initial_references("NameService");

        // get reference to Deal object
        NamingContext ncRef = NamingContextHelper.narrow(o);
        NameComponent[] nc = new NameComponent[1];
        nc[0]       = new NameComponent();
        nc[0].id    = "Deal";
        nc[0].kind  = "";
        Deal d = DealHelper.narrow(ncRef.resolve(nc));

        InputStreamReader isr = new InputStreamReader(System.in);
        BufferedReader in = new BufferedReader(isr);
        System.out.print("name > ");
        String name = in.readLine();            // get name
        System.out.print("number > ");
        String n = in.readLine();               // get quantity
        int number = Integer.parseInt(n);

        d.addBuy(new b(name, number));          // add new buy
        b[] bs = d.getBuys();                   // fetch buys
        for (int i=0; i<bs.length; i++)         // printout buys
          System.out.println(bs[i].name + " : " + bs[i].number);
      } catch (Exception e) {
        System.out.println("ERROR : " + e);
        e.printStackTrace(System.out);
      }
    }
  }

