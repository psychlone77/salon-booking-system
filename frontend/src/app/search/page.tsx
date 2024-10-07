"use client";

import React, { useState } from "react";
import {
  AdvancedMarker,
  APIProvider,
  Map,
  MapCameraChangedEvent,
  Pin,
} from "@vis.gl/react-google-maps";
import { Autocomplete, AutocompleteItem, Button, DatePicker } from "@nextui-org/react";
import { cities } from "../data";
import { getLocalTimeZone, today } from "@internationalized/date";
import SearchResults from "@/components/SearchResults";

type Poi = { key: string; location: google.maps.LatLngLiteral };
const locations: Poi[] = [
  { key: "1", location: { lat: 6.927079, lng: 79.861244 } },
  { key: "2", location: { lat: 6.8275, lng: 79.862 } },
  { key: "3", location: { lat: 6.8928, lng: 79.8563 } },
  { key: "4", location: { lat: 6.929, lng: 79.864 } },
  { key: "5", location: { lat: 6.93, lng: 79.865 } },
];

const salonData = [
    {
        id: 1,
        name: "Salon 1",
        address: "Address 1",
        rating: 4.5,
    },
    {
        id: 2,
        name: "Salon 2",
        address: "Address 2",
        rating: 4.0,
    },
    {
        id: 3,
        name: "Salon 3",
        address: "Address 3",
        rating: 3.5,
    },
    ];

const PoiMarkers = (props: { pois: Poi[] }) => {
  return (
    <>
      {props.pois.map((poi: Poi) => (
        <AdvancedMarker key={poi.key} position={poi.location}>
          <Pin background={"#BF9E75"} glyphColor={"#FFFFFF"} borderColor={"#FFFFFF"} />
        </AdvancedMarker>
      ))}
    </>
  );
};

export default function SearchPage() {
  return (
    <div className="flex font-serif">
      <div className="w-1/3 flex flex-col items-center gap-4 p-8 shadow-2xl">
        <Autocomplete defaultItems={cities} label="Select City" className="max-w-xl font-serif">
          {cities.map((city) => (
            <AutocompleteItem key={city.value}>{city.label}</AutocompleteItem>
          ))}
        </Autocomplete>
        <DatePicker
          className="font-serif max-w-xl"
          label="Booking Date"
          minValue={today(getLocalTimeZone())}
          defaultValue={today(getLocalTimeZone())}
        />
        <Button color="primary" className="h-12 w-64 text-xl">
          Search
        </Button>
        <SearchResults salons={salonData} />
      </div>
      <APIProvider
        apiKey={process.env.NEXT_PUBLIC_GMAPSKEY || ""}
        onLoad={() => console.log("Maps API has loaded.")}
      >
        <Map
          style={{ width: "100%", height: "100vh" }}
          mapId="6d349bf029cfc4e7"
          defaultZoom={13}
          defaultCenter={{ lat: 6.888582, lng: 79.863564 }}
        >
          <PoiMarkers pois={locations} />
        </Map>
      </APIProvider>
    </div>
  );
}
