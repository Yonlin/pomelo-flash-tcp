package org.idream.pomelo
{
	import flash.utils.ByteArray;

	public class Package
	{
		public static const PKG_HEAD_BYTES:int = 4;
		
		public static const TYPE_HANDSHAKE:int = 1;
		public static const TYPE_HANDSHAKE_ACK:int = 2;
		public static const TYPE_HEARTBEAT:int = 3;
		public static const TYPE_DATA:int = 4;
		public static const TYPE_KICK:int = 5;
		
		public static function encode(type:int, body:ByteArray = null):ByteArray
		{
			var length:int = body ? body.length : 0;
			var buffer:ByteArray = new ByteArray();
			buffer.writeByte(type & 0xff);
			buffer.writeByte((length >> 16) & 0xff);
			buffer.writeByte((length >> 8) & 0xff);
			buffer.writeByte(length & 0xff);
			
			if(body) {
				buffer.writeBytes(body, 0, body.length);
			}
			return buffer;
		}
		
		public static function decode(buffer:ByteArray):Object
		{
			var type:int = buffer.readUnsignedByte();
			var len:int = (buffer.readUnsignedByte() << 16 | buffer.readUnsignedByte() << 8 | buffer.readUnsignedByte()) >>> 0;
			trace(len);
			
			var body:ByteArray = new ByteArray();
			buffer.readBytes(body, 0, len);
			
			return { 'type':type, 'body':body };
		}
	}
}