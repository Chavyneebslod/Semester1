package Auctioning;

/**
* Auctioning/AuctionHolder.java .
* Generated by the IDL-to-Java compiler (portable), version "3.2"
* from src/auctioning.idl
* Tuesday, 30 November 2010 12:56:02 o'clock GMT
*/

public final class AuctionHolder implements org.omg.CORBA.portable.Streamable
{
  public Auctioning.Auction value = null;

  public AuctionHolder ()
  {
  }

  public AuctionHolder (Auctioning.Auction initialValue)
  {
    value = initialValue;
  }

  public void _read (org.omg.CORBA.portable.InputStream i)
  {
    value = Auctioning.AuctionHelper.read (i);
  }

  public void _write (org.omg.CORBA.portable.OutputStream o)
  {
    Auctioning.AuctionHelper.write (o, value);
  }

  public org.omg.CORBA.TypeCode _type ()
  {
    return Auctioning.AuctionHelper.type ();
  }

}