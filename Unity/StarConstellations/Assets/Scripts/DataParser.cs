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

	public StarDataStruct ParseData(string line)
	{
		var data = new StarDataStruct();
		var separatedData = line.Split('|');

		if (!hasPosition(separatedData)) {
			return data;
		}

		data.Declination.Value = ParseDeclination(separatedData[DecDataPosition]);
		data.RightAscension.Value = ParseRightAscension(separatedData[RaDataPosition]);
		data.Magnitude.Value = ParseMagnitude(separatedData[MagDataPosition]);
		data.Distance.Value = ParseDistance(separatedData[ParallaxDataPosition]);
		data.Position.Value = CalcPosition(data);
		data.HasPosition = true;

		return data;
	}

	private float ParseRightAscension(string dataLine)
	{
		if (!float.TryParse(dataLine, out var ra))
		{
			return 0;
		}
		return ra;
	}

	private float ParseDeclination(string dataLine)
	{
		if (!float.TryParse(dataLine, out var dec))
			return 0;
		dec += 90;
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
		var x = (MinDistance + DistanceMultiplier * star.Distance.Value) *
		        Mathf.Sin(star.Declination.Value) *
		        Mathf.Cos(star.RightAscension.Value);
		var y = (MinDistance + DistanceMultiplier * star.Distance.Value) *
		        Mathf.Sin(star.Declination.Value) *
		        Mathf.Sin(star.RightAscension.Value);
		var z = (MinDistance + DistanceMultiplier * star.Distance.Value) *
		        Mathf.Cos(star.Declination.Value);

		return new Vector3(x, y, z);
	}

	public Color ParseStarColour()
	{
		//todo look for conversion to color
		return new Color(Random.Range(0,255), Random.Range(0, 255), Random.Range(0, 255));
	}

	public bool hasPosition(string[] seperatedData) {
		bool hasPosition = false;

		if (seperatedData[DecDataPosition] != null ||
			seperatedData[RaDataPosition] != null ||
			seperatedData[ParallaxDataPosition] != null)
		{
			hasPosition = true;
		}

		return hasPosition;
	}
	
}