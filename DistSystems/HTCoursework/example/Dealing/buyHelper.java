package Dealing;


/**
* Dealing/buyHelper.java .
* Generated by the IDL-to-Java compiler (portable), version "3.2"
* from dealing.idl
* Friday, 26 November 2010 16:43:44 o'clock GMT
*/

abstract public class buyHelper
{
  private static String  _id = "IDL:Dealing/buy:1.0";

  public static void insert (org.omg.CORBA.Any a, Dealing.b that)
  {
    org.omg.CORBA.portable.OutputStream out = a.create_output_stream ();
    a.type (type ());
    write (out, that);
    a.read_value (out.create_input_stream (), type ());
  }

  public static Dealing.b extract (org.omg.CORBA.Any a)
  {
    return read (a.create_input_stream ());
  }

  private static org.omg.CORBA.TypeCode __typeCode = null;
  synchronized public static org.omg.CORBA.TypeCode type ()
  {
    if (__typeCode == null)
    {
      __typeCode = Dealing.bHelper.type ();
      __typeCode = org.omg.CORBA.ORB.init ().create_alias_tc (Dealing.buyHelper.id (), "buy", __typeCode);
    }
    return __typeCode;
  }

  public static String id ()
  {
    return _id;
  }

  public static Dealing.b read (org.omg.CORBA.portable.InputStream istream)
  {
    Dealing.b value = null;
    value = Dealing.bHelper.read (istream);
    return value;
  }

  public static void write (org.omg.CORBA.portable.OutputStream ostream, Dealing.b value)
  {
    Dealing.bHelper.write (ostream, value);
  }

}