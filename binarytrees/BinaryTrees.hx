/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Ian Martins
*/

import neko.Sys;
import neko.Lib;

class BinaryTrees
{
  inline private static var minDepth = 4;

  public static function main()
  {
    var num = Std.parseInt(Sys.args()[0]);

    var maxDepth = (minDepth+2 > num) ? minDepth+2 : num;
    var stretchDepth = maxDepth + 1;

    var check = TreeNode.bottomUpTree(0, stretchDepth).itemCheck();
    Lib.println("stretch tree of depth "+stretchDepth+"\t check: " + check);

    var longLivedTree = TreeNode.bottomUpTree(0, maxDepth);

    var depth = minDepth;
    while( depth <= maxDepth )
    {
      var iterations = 1 << (maxDepth - depth + minDepth);
      check = 0;

      for( ii in 1...iterations+1 )
      {
	check += TreeNode.bottomUpTree(ii, depth).itemCheck();
	check += TreeNode.bottomUpTree(-ii, depth).itemCheck();
      }
      Lib.println((iterations*2) + "\t tree