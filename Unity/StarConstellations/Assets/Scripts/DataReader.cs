using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using DefaultNamespace;
using UnityEngine;

public class DataReader
{
	private const string FileName = "hip_main.dat";
	private readonly string _path = Application.dataPath + "/Resources/" + FileName;
	private DataParser _dataParser;

	public DataReader()
	{
		_dataParser = new DataParser();
	}

    public List<StarDataStruct> ReadFile()
	{
        var _starDataStructs = new List<StarDataStruct>();
        Debug.Log("Loading File from: " + _path);
		if (!File.Exists(_path))
		{
			Debug.Log("Loading File failed.");
			return null;
		}

		using (var streamReader = new StreamReader(File.Open(_path, FileMode.Open)))
		{
			string line;
            
            while ((line = streamReader.ReadLine()) != null)
			{
				var dataStruct = _dataParser.ParseData(line);
				if (dataStruct.HasPosition)
				{
                    _starDataStructs.Add(dataStruct);
				}
			}
		}
		return _starDataStructs;
	}
}