using System;
using System.Collections.Generic;
using DefaultNamespace;
using JetBrains.Annotations;
using UnityEngine;

public class DataParser
{
	//Adjustments
	private const int MinDistance = 50;
	private const int DistanceMultiplier = 2;
	//Catalogue data positions
	private const int MagDataPosition = 5;
	private const int RaDataPosition = 8;
	private const int DecDataPosition = 9;
	private const int ParallaxDataPosition = 11;
	
	private string[] _starDataList;
	private DataReader _reader;

	public StarDataStruct ParseData(string line)
	{
		var data = new StarDataStruct();
		var separatedData = line.Split('|');

		if (separatedData[DecDataPosition] == null ||
		    separatedData[RaDataPosition] == null ||
		    separatedData[ParallaxDataPosition] == null)
		{
			data.HasPosition = false;
			return data;
		}

		data.Declination = ParseDeclination(separatedData[DecDataPosition]);
		data.RightAscension = ParseRightAscension(separatedData[RaDataPosition]);
		data.Magnitude = ParseMagnitude(separatedData[MagDataPosition]);
		data.Distance = ParseDistance(separatedData[ParallaxDataPosition]);
		data.Position = CalcPosition(data);
		data.HasPosition = true;


		return data;
	}

	private float ParseRightAscension(string dataLine)
	{
		if (!float.TryParse(dataLine, out var ra))
		{
			return 0;
		}
		Debug.Log(ra);
		return ra;
	}

	private float ParseDeclination(string dataLine)
	{
		if (!float.TryParse(dataLine, out var dec))
			return 0;
		dec = +90;
		return dec;
	}

	private float ParseDistance(string dataLine)
	{
		if (float.TryParse(dataLine, out var distance))
		{
			if (distance > 0)
			{
				distance = 1 / (distance / 1000);
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

	private Vector3 CalcPosition(StarDataStruct star)
	{
		//in radians
		// var x = DistanceMultiplier *
		//         star.Distance *
		//         Mathf.Sin(f: Mathf.Deg2Rad * star.Declination) *
		//         Mathf.Cos(Mathf.Deg2Rad * star.RightAscension);
		// var y = DistanceMultiplier *
		//         star.Distance *
		//         Mathf.Sin(f: Mathf.Deg2Rad * star.Declination) *
		//         Mathf.Sin(Mathf.Deg2Rad * star.RightAscension);
		// var z = DistanceMultiplier * star.Distance * 
		//         Mathf.Cos(Mathf.Deg2Rad * star.Declination);

		//In degrees
		var x = (MinDistance + DistanceMultiplier * star.Distance) *
		        Mathf.Sin(star.Declination) *
		        Mathf.Cos(star.RightAscension);
		var y = (MinDistance + DistanceMultiplier * star.Distance) *
		        Mathf.Sin(star.Declination) *
		        Mathf.Sin(star.RightAscension);
		var z = (MinDistance + DistanceMultiplier * star.Distance) *
		        Mathf.Cos(star.Declination);

		return new Vector3(x, y, z);
	}

	public Color ParseStarColour()
	{
		//todo look for conversion to color
		return new Color();
	}
}