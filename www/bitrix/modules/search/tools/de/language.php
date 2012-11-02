<?
class CSearchLanguageDe extends CSearchLanguage
{
	function GetKeyboardLayout()
	{
		return array(
			"lo" => "           ß ".
				"qwertzuiopü ".
				"asdfghjklöä".
				"yxcvbnm   ",
			"hi" => "             ".
				"QWERTZUIOPÜ ".
				"ASDFGHJKLÖÄ".
				"YXCVBNM   "
		);
	}
	function GetBigrammLetterFreq()
	{
		return array(
		//            a,   b,   c,   d,   e,   f,   g,   h,   i,   j,   k,   l,   m,   n,   o,   p,   q,   r,   s,   t,   u,   v,   w,   x,   y,   z,   ß,   ä,   ö,   ü,
		"a"=>array(   0,  81,  74,  26,   3,  36,  76,  62,  14,   0,  19, 165,  79, 280,   0,  12,   0, 147, 122, 121, 219,   5,   1,   2,   4,   5,  17,   0,   0,   0,),
		"b"=>array(  48,   0,   0,   0, 297,   1,   6,   2,  40,   0,   0,  23,   0,   2,  15,   0,   0,  30,  17,  13,  28,   0,   2,   0,   1,   1,   0,   2,   2,   8,),
		"c"=>array(   5,   0,   0,   3,   6,   0,   0, 680,   2,   0,  44,   2,   0,null,   8,   0,   0,   1,   1,   0,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0,),
		"d"=>array( 138,   1,   0,   0, 590,   2,   2,   2, 248,   0,   1,  10,   2,   4,  28,   1,   0,  25,  12,  11,  32,   0,   3,   0,   1,   0,   0,   1,   0,   3,),
		"e"=>array(  14,  57,  37,  51,   0,  34,  78,  91, 505,   0,  26, 171, 110,1028,   5,  12,   0,1024, 264, 114,  74,   6,  28,   9,   2,  11,   8,   0,   0,   0,),
		"f"=>array(  42,   2,   0,   1,  68,   0,   6,   1,  26,   0,   1,  17,   1,   3,  28,   0,   0,  43,   7,  53,  12,   0,   1,   0,   0,   1,   0,   8,   2,  58,),
		"g"=>array(  41,   1,   0,   0, 402,   1,   0,   2,  33,   0,   4,  26,   1,   7,   6,   0,   0,  44,  39,  40,  20,   0,   0,   0,   0,   1,   0,   3,   0,   2,),
		"h"=>array( 147,   3,   0,   1, 252,   1,   2,   0,  49,   0,   4,  58,  26,  44,  35,   0,   0, 118,  21, 129,  23,   0,  15,   0,   1,   1,   0,  23,  14,   5,),
		"i"=>array(  18,  17, 222,  28, 456,  14, 104,  30,   0,   0,  27,  75,  74, 475,  50,   5,   0,  54, 195, 217,   4,  16,   0,   0,   0,  12,   6,   0,   0,   0,),
		"j"=>array(  30,   0,   0,   0,  21,   0,   0,   0,   0,   0,   0,   0,   0,   0,   4,   0,null,   0,   0,   0,  10,   0,   0,   0,   0,   0,   0,   5,   0,   2,),
		"k"=>array(  53,   0,   0,   0,  70,   2,   2,   1,  16,   0,   0,  27,   1,   3,  55,   0,   0,  25,   9,  47,  25,   0,   1,   0,   0,   1,   0,   3,  14,   8,),
		"l"=>array( 100,  17,   4,  25, 192,  12,  11,   2, 167,   0,   7,   0,   7,   9,  29,   3,   0,   2,  51,  82,  32,   2,   1,   0,   3,   4,   0,  25,   4,   5,),
		"m"=>array(  96,  11,   0,   1, 131,   2,   2,   0, 115,   0,   1,   4,   0,   1,  24,  17,   0,   1,  11,  17,  23,   0,   2,   0,   0,   0,   0,   7,   7,  11,),
		"n"=>array(  95,  15,   9, 319, 273,  24, 207,  12, 110,   1,  38,  11,   8,   0,  37,   3,   0,   5, 102, 148,  36,   5,   7,   0,   1,  41,   0,   7,   1,   3,),
		"o"=>array(   3,  20,  45,  20,   1,  18,  15,  21,   2,   1,   6,  77,  44, 167,   0,  18,   0, 130,  34,  26,   6,   5,   7,   0,   1,  14,   9,   0,   0,   0,),
		"p"=>array(  36,   0,   0,   4,  32,  16,   0,   6,  26,   0,   0,  17,   0,   0,  28,   0,   0,  64,   2,  10,  10,   0,   0,   0,   0,   0,   0,   5,   0,   0,),
		"q"=>array(   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   6,   0,   0,   0,   0,   0,null,   0,null,null,),
		"r"=>array( 134,  39,  19,  94, 266,  27,  48,  25, 121,   1,  45,  37,  28,  63,  81,   7,   0,   0,  91, 130,  68,   5,  17,   0,   1,  23,   0,  22,   8,  27,),
		"s"=>array(  61,  10, 232,   3, 212,   7,  16,  13, 147,   0,  13,  13,  10,   2,  74,  62,   0,   9,   0, 320,  20,   7,   9,   0,   4,   6,   0,   5,   1,   2,),
		"t"=>array(  95,   6,   1,   2, 487,   4,   9,  20, 128,   0,   2,  27,   6,   5,  38,   2,   0,  81,  82,   0,  45,   3,  18,   0,   2,  61,   0,  20,   3,   9,),
		"u"=>array(   7,  13,  50,  10,  32,  77,  21,   9,   2,   0,   7,  22,  67, 323,   0,  11,   0, 103, 112,  64,   0,   2,   1,   0,   0,   3,  14,   0,   0,   0,),
		"v"=>array(   8,   0,   0,   0, 108,   0,   0,   0,  25,   0,   0,   0,   0,   0, 105,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   2,   0,),
		"w"=>array(  70,   0,   0,   0, 137,   0,   0,   0, 100,   0,   0,   0,   0,   0,  38,   0,   0,   0,   1,   0,  17,   0,   0,   0,   0,   0,null,  12,   2,   7,),
		"x"=>array(   0,   0,   0,   0,   1,   0,   0,   0,   2,   0,   0,   0,   0,   0,   0,   2,   0,   0,   0,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,),
		"y"=>array(   0,   0,   0,   0,   3,   0,   0,   0,   0,   0,   0,   1,   2,   1,   1,   1,   0,   0,   4,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,),
		"z"=>array(   9,   1,   0,   1,  83,   0,   0,   0,  33,   0,   0,   5,   1,   0,   4,   0,   0,   0,   1,  20, 114,   0,  23,   0,   0,   0,   0,   2,   1,   1,),
		"ß"=>array(   0,   2,   0,   0,  22,   0,   0,   0,   1,   0,   0,   2,   0,   0,   0,   0,   0,   0,   0,   8,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,),
		"ä"=>array(   0,   0,  11,   4,   0,   7,   7,  18,   1,   0,   0,   9,   4,  28,   0,   0,   0,  19,  10,  22,  11,   0,   0,   0,   0,   0,   2,   0,   0,   0,),
		"ö"=>array(   0,   0,   2,   2,   0,   4,   5,   5,   0,   0,   0,   5,   0,  14,   0,   1,null,  13,   5,   3,   0,   0,   0,   0,   0,   0,   3,null,   0,null,),
		"ü"=>array(   0,  27,  17,   3,   0,   1,   4,  18,   0,null,   0,   4,   1,  23,   0,   0,null,  62,   9,   6,   0,   0,   0,   0,   0,   0,   1,null,null,   0,),
		);
	}
}
?>