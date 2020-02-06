using System;
using System.Collections.Generic;
using DefaultNamespace;
using JetBrains.Annotations;
using UnityEngine;

public class DataParser
{
	private const int DecDataPosition = 8;
	private const int RaDataPosition = 9;
	private const int MagDataPosition = 11;
	private const int DistDataPosition = 11;
	private string[] _starDataList;
	private DataReader _reader;

	public StarDataStruct ParseData(string line)
	{
		var data = new StarDataStruct();
		var separatedData = line.Split('|');

		if (separatedData[DecDataPosition] == null ||
		    separatedData[RaDataPosition] == null ||
		    separatedData[DistDataPosition] == null)
		{
			data.HasPosition = false;
			return data;
		}

		data.Declination = ParseDeclination(separatedData[DecDataPosition]);
		data.RightAscension = ParseRightAscension(separatedData[RaDataPosition]);
		data.Magnitude = ParseMagnitude(separatedData[MagDataPosition]);
		data.Distance = ParseDistance(separatedData[DistDataPosition]);
		data.HasPosition = true;
		
		return data;
	}

	private float ParseRightAscension(string dataLine)
	{
		if (float.TryParse(dataLine, out var ra))
		{
			return ra;
		}

		return 0;
	}

	private float ParseDeclination(string dataLine)
	{
		if (!float.TryParse(dataLine, out var dec))
			return 0;
		if (dec < 0)
		{
			dec = (dec * -1) + 90;
		}
		else
		{
			dec = 90 - dec;
		}

		return dec;
	}

	private float ParseDistance(string dataLine)
	{
		if (float.TryParse(dataLine, out var distance))
		{
			if(distance > 0)
			{
				distance = 1/(distance/1000);
			}
			else
			{
				distance = 0;
			}
		}

		return distance;
	}

	private float ParseMagnitude(string dataLine)
	{
		if (float.TryParse(dataLine, out var magnitude))
		{
			return magnitude;
		}

		return 0;
	}

	public Color ParseStarColour()
	{
		//todo look for conversion to color
		return new Color();
	}
}