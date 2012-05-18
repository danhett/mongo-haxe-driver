package org.mongodb;

class Collection
{
	public function new(name:String, db:Database)
	{
		this.name = name;
		this.fullname = db.name + "." + name;
		this.db = db;
	}

	public function find(?query:Dynamic, ?returnFields:Dynamic, skip:Int = 0, number:Int = 0):Cursor
	{
		Protocol.query(fullname, query, returnFields, skip, number);
		return new Cursor(fullname);
	}

	public function findOne(?query:Dynamic, ?returnFields:Dynamic):Dynamic
	{
		Protocol.query(fullname, query, returnFields, 0, -1);
		return Protocol.getOne();
	}

	public function insert(fields:Dynamic)
	{
		Protocol.insert(fullname, fields);
	}

	public function update(select:Dynamic, fields:Dynamic)
	{
		Protocol.update(fullname, select, fields);
	}

	public function remove(select:Dynamic)
	{
		Protocol.remove(fullname, select);
	}

	public function create() { db.createCollection(name); }
	public function drop() { db.dropCollection(name); }
	public function rename(to:String) { db.renameCollection(name, to); }

	public function count():Int
	{
		var result = db.runCommand({count: name});
		return result.n;
	}

	public var fullname(default, null):String;
	public var name(default, null):String;
	private var db:Database;

}