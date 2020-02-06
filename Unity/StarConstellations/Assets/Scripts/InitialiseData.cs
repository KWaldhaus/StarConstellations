using System.Collections.Generic;
using UnityEngine;

namespace DefaultNamespace
{
	public class InitialiseData : MonoBehaviour
	{
		private void Start()
		{
			StarData starData = new StarData();
			starData.GetStars();
		}
	}
}