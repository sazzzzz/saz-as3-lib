package saz.template
{
	public class SoundData
	{
		
		[Embed(source="../assets/bgm.mp3")]			private static var BgmSound:Class;
		[Embed(source="../assets/shock.mp3")]		private static var ShockSound:Class;
		
		[Embed(source="../assets/backcomp.mp3")]	private static var BackcompSound:Class;
		
		[Embed(source="../assets/intro.mp3")]		private static var IntroSound:Class;
		[Embed(source="../assets/cover.mp3")]		private static var CoverSound:Class;
		
		[Embed(source="../assets/q_kouen.mp3")]				private static var QKouenSound:Class;
		[Embed(source="../assets/q_danchi.mp3")]			private static var QDanchiSound:Class;
		[Embed(source="../assets/q_yabai.mp3")]				private static var QYabaiSound:Class;
		
		[Embed(source="../assets/q_kyoraku.mp3")]			private static var QKyorakuSound:Class;
		[Embed(source="../assets/q_onechan.mp3")]			private static var QOnechanSound:Class;
		[Embed(source="../assets/q_pachinko.mp3")]			private static var QPachinkoSound:Class;
		[Embed(source="../assets/q_tomodachi.mp3")]			private static var QTomodachiSound:Class;
		
		[Embed(source="../assets/q_polter.mp3")]			private static var QPolterSound:Class;
		[Embed(source="../assets/q_sasahara.mp3")]			private static var QSasaharaSound:Class;
		[Embed(source="../assets/q_ninomiya.mp3")]			private static var QNinomiyaSound:Class;
		[Embed(source="../assets/q_jinmen.mp3")]			private static var QJinmenSound:Class;
		[Embed(source="../assets/q_hazard.mp3")]			private static var QHazardSound:Class;
		[Embed(source="../assets/q_kinoshita.mp3")]			private static var QKinoshitaSound:Class;
		
		[Embed(source="../assets/game.mp3")]		private static var GameSound:Class;
		[Embed(source="../assets/card_hover.mp3")]	private static var CardHoverSound:Class;
//		[Embed(source="../assets/atari1.mp3")]		private static var Atari1Sound:Class;
//		[Embed(source="../assets/atari2.mp3")]		private static var Atari2Sound:Class;
//		[Embed(source="../assets/hazure1.mp3")]		private static var Hazure1Sound:Class;
//		[Embed(source="../assets/hazure2.mp3")]		private static var Hazure2Sound:Class;
//		[Embed(source="../assets/hazure3.mp3")]		private static var Hazure3Sound:Class;
		[Embed(source="../assets/clear1.mp3")]		private static var Clear1Sound:Class;
		[Embed(source="../assets/clear2.mp3")]		private static var Clear2Sound:Class;
		[Embed(source="../assets/shockcomp.mp3")]	private static var ShockcompSound:Class;
		
//		[Embed(source="../assets/asioto.mp3")]		private static var AsiotoSound:Class;
		[Embed(source="../assets/door_open.mp3")]	private static var DoorOpenSound:Class;
		[Embed(source="../assets/door_close.mp3")]	private static var DoorCloseSound:Class;
		
		[Embed(source="../assets/laugh1.mp3")]	private static var Laugh1Sound:Class;
		[Embed(source="../assets/laugh6.mp3")]	private static var Laugh2Sound:Class;
		[Embed(source="../assets/laugh11.mp3")]	private static var Laugh3Sound:Class;
		[Embed(source="../assets/laugh18.mp3")]	private static var Laugh4Sound:Class;
		[Embed(source="../assets/laugh20.mp3")]	private static var Laugh5Sound:Class;
		
		
		public static const SOUND_DATAS:Array = [
			{name:"bgm", loops:int.MAX_VALUE, volume:1.0, pan:0.0, sound:new BgmSound()}
			,{name:"shock", loops:0, volume:1.0, pan:0.0, sound:new ShockSound()}
			
			,{name:"backcomp", loops:0, volume:1.0, pan:0.0, sound:new BackcompSound()}
			
			,{name:"intro", loops:0, volume:1.0, pan:0.0, sound:new IntroSound()}
			,{name:"cover", loops:0, volume:1.0, pan:0.0, sound:new CoverSound()}
			
			,{name:"q_kouen", loops:0, volume:1.0, pan:0.0, sound:new QKouenSound()}
			,{name:"q_danchi", loops:0, volume:1.0, pan:0.0, sound:new QDanchiSound()}
			,{name:"q_yabai", loops:0, volume:1.0, pan:0.0, sound:new QYabaiSound()}
			
			,{name:"q_kyoraku", loops:0, volume:1.0, pan:0.0, sound:new QKyorakuSound()}
			,{name:"q_onechan", loops:0, volume:1.0, pan:0.0, sound:new QOnechanSound()}
			,{name:"q_pachinko", loops:0, volume:1.0, pan:0.0, sound:new QPachinkoSound()}
			,{name:"q_tomodachi", loops:0, volume:1.0, pan:0.0, sound:new QTomodachiSound()}
			
			,{name:"q_polter", loops:0, volume:1.0, pan:0.0, sound:new QPolterSound()}
			,{name:"q_sasahara", loops:0, volume:1.0, pan:0.0, sound:new QSasaharaSound()}
			,{name:"q_ninomiya", loops:0, volume:1.0, pan:0.0, sound:new QNinomiyaSound()}
			,{name:"q_jinmen", loops:0, volume:1.0, pan:0.0, sound:new QJinmenSound()}
			,{name:"q_hazard", loops:0, volume:1.0, pan:0.0, sound:new QHazardSound()}
			,{name:"q_kinoshita", loops:0, volume:1.0, pan:0.0, sound:new QKinoshitaSound()}
			
			,{name:"game", loops:0, volume:1.0, pan:0.0, sound:new GameSound()}
			,{name:"card_hover", loops:0, volume:0.7, pan:0.0, sound:new CardHoverSound()}
//			,{name:"atari", loops:0, volume:1.0, pan:0.0
//				, sounds:[new Atari1Sound(), new Atari2Sound()]}
//			,{name:"hazure", loops:0, volume:1.0, pan:0.0
//				, sounds:[new Hazure1Sound(), new Hazure2Sound(), new Hazure3Sound()]}
			,{name:"clear1", loops:0, volume:1.0, pan:0.0, sound:new Clear1Sound()}
			,{name:"clear2", loops:0, volume:1.0, pan:0.0, sound:new Clear2Sound()}
			,{name:"shockcomp", loops:0, volume:1.0, pan:0.0, sound:new ShockcompSound()}
			
//			,{name:"asioto", loops:0, volume:0.3, pan:0.0, sound:new AsiotoSound()}
			,{name:"door_open", loops:0, volume:0.2, pan:0.0, sound:new DoorOpenSound()}
			,{name:"door_close", loops:0, volume:0.4, pan:0.0, sound:new DoorCloseSound()}
			
			,{name:"laugh", loops:0, volume:0.6, pan:0.0
				, sounds:[new Laugh1Sound(), new Laugh2Sound(), new Laugh3Sound(), new Laugh4Sound(), new Laugh5Sound()]}
		];
		
	}
}