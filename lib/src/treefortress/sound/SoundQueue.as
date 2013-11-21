package treefortress.sound
{
	
	/**
	 * ...
	 * @author Espigah
	 */
	public class SoundQueue
	{
		public var queue:Vector.<Object>;
		
		public function SoundQueue(length:uint = 0, fixed:Boolean = false)
		{
			queue = new Vector.<Object>(length,fixed);
		}
		
		public function add(url:String, type:String, buffer:int = 100):void
		{
			queue[queue.length] = {url: url, type: type, buffer: buffer};			
		}
		
		public function iterator(onIterator:Function):void
		{
			const LENGTH:int = queue.length-1;
			for (var i:int = LENGTH; i >=0 ; i--)
			{
				onIterator(i, queue[i]);
			}
		}
	
	}

}