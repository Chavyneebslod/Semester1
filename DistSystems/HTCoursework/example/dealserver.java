  import org.omg.CORBA.*;
  import org.omg.CosNaming.*;
  import org.omg.PortableServer.*;
  import Dealing.*;

  public class dealserver {
    public static void main(String args[]) {
      try {
        ORB orb = ORB.init(args, null);      // initialize ORB
        POA rootpoa = POAHelper.narrow(
                      orb.resolve_initial_references("RootPOA"));
        rootpoa.the_POAManager().activate(); // activate POAManager
        DealImpl di = new DealImpl();        // implement Deal
        org.omg.CORBA.Object o = rootpoa.servant_to_reference(di);
        Deal deal = DealHelper.narrow(o);    // get ref to object
        o = orb.resolve_initial_references("NameService");
        NamingContext ncRef = NamingContextHelper.narrow(o);
        NameComponent[] nc = new NameComponent[1];
        nc[0]       = new NameComponent();
        nc[0].id    = "Deal";
        nc[0].kind  = "";
        ncRef.rebind(nc, deal);              // bind name to object
        System.out.println("Deal Server is ready");
        orb.run();                           // set orb running
      } catch (Exception e) { System.err.println("Error: " + e); }
    }
  }

