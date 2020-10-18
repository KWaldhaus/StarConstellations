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

        Entity starEntitiy;
        private EntityManager entityManager;
        private List<StarDataStruct> _starDataStructs = new List<StarDataStruct>();

        public void Start()
        {
            DataReader dataReader = new DataReader();
            _starDataStructs = dataReader.ReadFile();

            SpawnStars();
            World world = World.DefaultGameObjectInjectionWorld;
            entityManager = world.EntityManager;
            GameObjectConversionSettings settings = new GameObjectConversionSettings(world, GameObjectConversionUtility.ConversionFlags.AssignName);
            starEntitiy = GameObjectConversionUtility.ConvertGameObjectHierarchy(starPrefab, settings);
        }

        private void SpawnStars()
        {
            for (int i = 0; i < _starDataStructs.Count; i++)
            {
                var star = entityManager.Instantiate(starEntitiy);
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