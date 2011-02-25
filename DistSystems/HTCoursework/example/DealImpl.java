  import java.io.*;
  import java.util.*;
  import Dealing.*;

  public class DealImpl extends DealPOA {
    private Vector v;
    public DealImpl() { v = new Vector(); }

    public void addBuy(b B) { v.addElement(B); }

    public b[] getBuys() {
      b[] bs = new b[v.size()]; // create array from vector
      for (int i=0; i<v.size(); i++) 
        bs[i] = (b)v.elementAt(i);   
      return bs;                // return array
    }
  }

