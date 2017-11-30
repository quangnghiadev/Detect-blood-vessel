/*
* MATLAB Compiler: 6.2 (R2016a)
* Date: Thu Nov 30 10:09:50 2017
* Arguments: "-B" "macro_default" "-W" "dotnet:fuck,Class1,4.0,private" "-T" "link:lib"
* "-d" "C:\Users\Asus\Documents\Detect-blood-vessel\fuck\for_testing" "-v"
* "class{Class1:C:\Users\Asus\Documents\Detect-blood-vessel\acode_fileExchange_941\For
* C#\fuck.m}" 
*/
using System;
using System.Reflection;
using System.IO;
using MathWorks.MATLAB.NET.Arrays;
using MathWorks.MATLAB.NET.Utility;

#if SHARED
[assembly: System.Reflection.AssemblyKeyFile(@"")]
#endif

namespace fuckNative
{

  /// <summary>
  /// The Class1 class provides a CLS compliant, Object (native) interface to the MATLAB
  /// functions contained in the files:
  /// <newpara></newpara>
  /// C:\Users\Asus\Documents\Detect-blood-vessel\acode_fileExchange_941\For C#\fuck.m
  /// </summary>
  /// <remarks>
  /// @Version 4.0
  /// </remarks>
  public class Class1 : IDisposable
  {
    #region Constructors

    /// <summary internal= "true">
    /// The static constructor instantiates and initializes the MATLAB Runtime instance.
    /// </summary>
    static Class1()
    {
      if (MWMCR.MCRAppInitialized)
      {
        try
        {
          Assembly assembly= Assembly.GetExecutingAssembly();

          string ctfFilePath= assembly.Location;

          int lastDelimiter= ctfFilePath.LastIndexOf(@"\");

          ctfFilePath= ctfFilePath.Remove(lastDelimiter, (ctfFilePath.Length - lastDelimiter));

          string ctfFileName = "fuck.ctf";

          Stream embeddedCtfStream = null;

          String[] resourceStrings = assembly.GetManifestResourceNames();

          foreach (String name in resourceStrings)
          {
            if (name.Contains(ctfFileName))
            {
              embeddedCtfStream = assembly.GetManifestResourceStream(name);
              break;
            }
          }
          mcr= new MWMCR("",
                         ctfFilePath, embeddedCtfStream, true);
        }
        catch(Exception ex)
        {
          ex_ = new Exception("MWArray assembly failed to be initialized", ex);
        }
      }
      else
      {
        ex_ = new ApplicationException("MWArray assembly could not be initialized");
      }
    }


    /// <summary>
    /// Constructs a new instance of the Class1 class.
    /// </summary>
    public Class1()
    {
      if(ex_ != null)
      {
        throw ex_;
      }
    }


    #endregion Constructors

    #region Finalize

    /// <summary internal= "true">
    /// Class destructor called by the CLR garbage collector.
    /// </summary>
    ~Class1()
    {
      Dispose(false);
    }


    /// <summary>
    /// Frees the native resources associated with this object
    /// </summary>
    public void Dispose()
    {
      Dispose(true);

      GC.SuppressFinalize(this);
    }


    /// <summary internal= "true">
    /// Internal dispose function
    /// </summary>
    protected virtual void Dispose(bool disposing)
    {
      if (!disposed)
      {
        disposed= true;

        if (disposing)
        {
          // Free managed resources;
        }

        // Free native resources
      }
    }


    #endregion Finalize

    #region Methods

    /// <summary>
    /// Provides a single output, 0-input Objectinterface to the fuck MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// $$I_1=R_{I_o}\left (max\left\{\gamma_{B_i} (I_o)\right\}\right), &amp;
    /// i=1,...,12$$ 
    /// INPUT: 
    /// IM (complemented green channel of a color retina image)
    /// LEN (defualt: 11)
    /// DEG_NUM (defualt:12)
    /// OUTPUT: 
    /// imC2 
    /// </remarks>
    /// <returns>An Object containing the first output argument.</returns>
    ///
    public Object fuck()
    {
      return mcr.EvaluateFunction("fuck", new Object[]{});
    }


    /// <summary>
    /// Provides the standard 0-input Object interface to the fuck MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// $$I_1=R_{I_o}\left (max\left\{\gamma_{B_i} (I_o)\right\}\right), &amp;
    /// i=1,...,12$$ 
    /// INPUT: 
    /// IM (complemented green channel of a color retina image)
    /// LEN (defualt: 11)
    /// DEG_NUM (defualt:12)
    /// OUTPUT: 
    /// imC2 
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public Object[] fuck(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "fuck", new Object[]{});
    }


    /// <summary>
    /// Provides an interface for the fuck function in which the input and output
    /// arguments are specified as an array of Objects.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// $$I_1=R_{I_o}\left (max\left\{\gamma_{B_i} (I_o)\right\}\right), &amp;
    /// i=1,...,12$$ 
    /// INPUT: 
    /// IM (complemented green channel of a color retina image)
    /// LEN (defualt: 11)
    /// DEG_NUM (defualt:12)
    /// OUTPUT: 
    /// imC2 
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of Object output arguments</param>
    /// <param name= "argsIn">Array of Object input arguments</param>
    /// <param name= "varArgsIn">Array of Object representing variable input
    /// arguments</param>
    ///
    [MATLABSignature("fuck", 0, 1, 0)]
    protected void fuck(int numArgsOut, ref Object[] argsOut, Object[] argsIn, params Object[] varArgsIn)
    {
        mcr.EvaluateFunctionForTypeSafeCall("fuck", numArgsOut, ref argsOut, argsIn, varArgsIn);
    }

    /// <summary>
    /// This method will cause a MATLAB figure window to behave as a modal dialog box.
    /// The method will not return until all the figure windows associated with this
    /// component have been closed.
    /// </summary>
    /// <remarks>
    /// An application should only call this method when required to keep the
    /// MATLAB figure window from disappearing.  Other techniques, such as calling
    /// Console.ReadLine() from the application should be considered where
    /// possible.</remarks>
    ///
    public void WaitForFiguresToDie()
    {
      mcr.WaitForFiguresToDie();
    }



    #endregion Methods

    #region Class Members

    private static MWMCR mcr= null;

    private static Exception ex_= null;

    private bool disposed= false;

    #endregion Class Members
  }
}
