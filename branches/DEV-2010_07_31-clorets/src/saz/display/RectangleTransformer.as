package saz.display {
	import flash.geom.*;
	/**
	 * 長方形の変換行列を作成するクラス。
	 * @author saz
	 */
	public class RectangleTransformer {
		
		public var sourceRectangle:Rectangle;
		public var sourceRadian:Number;
		public var destinationRectangle:Rectangle;
		public var destinationRadian:Number;
		
		private var $mtxa:Matrix;
		private var $mtxb:Matrix;
		
		public function RectangleTransformer() {
			$init();
		}
		
		private function $init():void{
			sourceRectangle = new Rectangle();
			sourceRadian = 0;
			destinationRectangle = new Rectangle();
			destinationRadian = 0;
			
			$mtxa = new Matrix();
			$mtxb = new Matrix();
		}
		
		/**
		 * 変換行列を返す。
		 * @return
		 * @see	http://www.d-project.com/flex/009_FreeTransform/
		 */
		public function matrix():Matrix {
			// http://www.d-project.com/flex/009_FreeTransform/
			
			// createBoxだとゆがむ。なぜだ？
			//$mtxa.createBox(sourceRectangle.width, sourceRectangle.height, sourceRadian);
			//$mtxa.createBox(sourceRectangle.width, sourceRectangle.height, sourceRadian, sourceRectangle.x, sourceRectangle.y);
			
			$mtxa.identity();
			// scale()、rotate()、translate() の順番じゃないとダメ
			$mtxa.scale(sourceRectangle.width, sourceRectangle.height);
			$mtxa.rotate(sourceRadian);
			$mtxa.translate(sourceRectangle.x, sourceRectangle.y);
			$mtxa.invert();
			
			
			/*$mtxb.identity();
			$mtxb.scale(destinationRectangle.width, destinationRectangle.height);
			$mtxb.rotate(destinationRadian);
			$mtxb.translate(destinationRectangle.x, destinationRectangle.y);*/
			// こっちは平気?
			// createBox() = identity()、rotate()、scale()、translate() 
			$mtxb.createBox(destinationRectangle.width, destinationRectangle.height, destinationRadian, destinationRectangle.x, destinationRectangle.y);
			
			var res:Matrix = new Matrix();
			res.concat($mtxa);
			res.concat($mtxb);
			return res;
		}
		/*public function matrix():Matrix {
			trace("RectangleTransformer.matrix(", arguments);
			$mtxa.identity();
			$mtxa.scale(sourceRectangle.width, sourceRectangle.height);
			$mtxa.rotate(sourceRadian);
			//$mtxa.translate(sourceRectangle.x, sourceRectangle.y);
			// createBoxだとゆがむ。なぜだ？
			//$mtxa.createBox(sourceRectangle.width, sourceRectangle.height, sourceRadian, sourceRectangle.x, sourceRectangle.y);
			$mtxa.invert();
			
			//$mtxb.identity();
			//$mtxb.scale(destinationRectangle.width, destinationRectangle.height);
			//$mtxb.rotate(destinationRadian);
			//$mtxb.translate(destinationRectangle.x, destinationRectangle.y);
			$mtxb.createBox(destinationRectangle.width, destinationRectangle.height, destinationRadian);
			
			var res:Matrix = new Matrix();
			trace(res);
			res.translate( -sourceRectangle.x, -sourceRectangle.y);
			trace(res);
			res.concat($mtxa);
			trace(res);
			res.concat($mtxb);
			trace(res);
			res.translate(destinationRectangle.x, destinationRectangle.y);
			return res;
		}*/
		
		/*public function matrixFromPoints(src0:Point, src1:Point, src2:Point, dst0:Point, dst1:Point, dst2:Point):Matrix {
			$mtxa.a = src1.x - src0.x;
			$mtxa.b = src1.y - src0.y;
			$mtxa.c = src2.x - src0.x;
			$mtxa.d = src2.y - src0.y;
			$mtxa.invert();
			
			$mtxb.a = dst1.x - dst0.x;
			$mtxb.b = dst1.y - dst0.y;
			$mtxb.c = dst2.x - dst0.x;
			$mtxb.d = dst2.y - dst0.y;
			
			var res:Matrix = new Matrix();
			// 原点へ移動
			res.translate( -src0.x, -ao.y);
			// 単位行列に変換（srcの逆行列）
			res.concat($mtxa);
			// dstの座標系に変換
			res.concat($mtxb);
			// dst原点へ移動
			res.translate(dst0.x, dst0.y);
			return res;
		}*/
		
	}

}