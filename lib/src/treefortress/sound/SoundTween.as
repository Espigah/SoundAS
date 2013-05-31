package treefortress.sound
{
	import flash.utils.getTimer;
	
	public class SoundTween {
		
		public var startTime:int;
		public var startVolume:Number;
		public var endVolume:Number;
		public var duration:Number;
		public var sound:SoundInstance;
		
		protected var isMasterFade:Boolean;
		protected var _isComplete:Boolean;
		protected var _soundGroup:SoundManager;
		
		public function SoundTween(si:SoundInstance, endVolume:Number, duration:Number, isMasterFade:Boolean = false, group:SoundManager = null) {
			if(si){
				sound = si;
				startVolume = sound.volume;
			}
			this.isMasterFade = isMasterFade;
			this._soundGroup = group;
			init(startVolume, endVolume, duration);
		}
		
		public function update(t:int):Boolean {
			if(_isComplete){ return _isComplete; }
			
			if(isMasterFade){
				if (t - startTime < duration) {
					if (this._soundGroup) {
						this._soundGroup.masterVolume = easeOutQuad(t - startTime, startVolume, endVolume - startVolume, duration);
					}
					else {
						SoundAS.masterVolume = easeOutQuad(t - startTime, startVolume, endVolume - startVolume, duration);
					}
				} else {
					if (this._soundGroup) {
						this._soundGroup.masterVolume = endVolume;
					}
					else {
						SoundAS.masterVolume = endVolume;
					}
				}
				if (this._soundGroup) {
					_isComplete = this._soundGroup.masterVolume == endVolume;
				}
				else {
					_isComplete = SoundAS.masterVolume == endVolume;
				}
			} else {
				if(t - startTime < duration){
					sound.volume = easeOutQuad(t - startTime, startVolume, endVolume - startVolume, duration);
				} else {
					sound.volume = endVolume;
				}
				_isComplete = sound.volume == endVolume;
			}
			return _isComplete;
			
		}
		
		public function init(startVolume:Number, endVolume:Number, duration:Number):void {
			this.startTime = getTimer();
			this.startVolume = startVolume;
			this.endVolume = endVolume;
			this.duration = duration;
			_isComplete = false;
		}
		
		public function end(applyEndVolume:Boolean = false):void {
			_isComplete = true;
			if(applyEndVolume){
				sound.volume = endVolume;
			}
		}
		
		/**
		 * Equations from the man Robert Penner, see here for more:
		 * http://www.dzone.com/snippets/robert-penner-easing-equations
		 */
		protected static function easeOutQuad(position:Number, startValue:Number, change:Number, duration:Number):Number {
			return -change *(position/=duration)*(position-2) + startValue;
		};
		
		protected static function easeInOutQuad(position:Number, startValue:Number, change:Number, duration:Number):Number {
			if ((position/=duration/2) < 1){
				return change/2*position*position + startValue;
			}
			return -change/2 * ((--position)*(position-2) - 1) + startValue;
		}
		
		public function get isComplete():Boolean {
			return _isComplete;
		}


		
	}
}