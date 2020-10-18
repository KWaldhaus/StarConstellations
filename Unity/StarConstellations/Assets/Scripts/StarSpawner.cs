using System.Collections.Generic;
using Unity.Entities;
using Unity.Mathematics;
using Unity.Transforms;
using UnityEngine;

namespace DefaultNamespace
{
    public class StarSpawner : MonoBehaviour
    {
        public GameObject starPrefab;
        public int starAmount;

        private EntityManager entityManager;
        private List<StarDataStruct> _starDataStructs = new List<StarDataStruct>();

        public void Start()
        {
            DataReader dataReader = new DataReader();
            _starDataStructs = dataReader.ReadFile();

            SpawnStars();
            World world = World.DefaultGameObjectInjectionWorld;
            EntityManager entityManager = world.EntityManager;
        }

        private void SpawnStars()
        {
            for (int i = 0; i < _starDataStructs.Count; i++)
            {
                var star = entityManager.Instantiate(starPrefab);

                var distance = new Distance();
                distance.Value = 1;

                AddComponentData(star, _starDataStructs[i]);
            }
        }

        private void AddComponentData(Entity star, StarDataStruct starData) {

            var position = new Translation();
            position.Value = starData.Position.Value;
            entityManager.AddComponentData<Translation>(star, position);

            entityManager.AddComponentData<Distance>(star, starData.Distance);
            entityManager.AddComponentData<RightAscension>(star, starData.RightAscension);
            entityManager.AddComponentData<Declination>(star, starData.Declination);
            entityManager.AddComponentData<Magnitude>(star, starData.Magnitude);
            
        }
    }
}