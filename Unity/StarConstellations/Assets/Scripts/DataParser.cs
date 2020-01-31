using System.Collections.Generic;
using UnityEngine;

public class DataParser : MonoBehaviour
{
	private string FileName = "hip_main";
	private List<string> _starDataList;
	private List<Star> _starList;
	private DataReader _reader;

	private void Start()
	{
		_reader = new DataReader();
		_starList = new List<Star>();
		_starDataList = new List<string>();

		string path = Application.dataPath + "/Resources/" + FileName;
		_starDataList = _reader.ReadFile(path);
	}

	public void ParseRightAscension()
	{
		
	}

	public void ParseDeclination()
	{
	}

	public void ParseDistance()
	{
	}

	public void ParseMagnitude()
	{
	}

	public void ParseStarColour()
	{
	}
}