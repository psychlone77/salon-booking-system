"use client";

import { Autocomplete, AutocompleteItem, Button, DatePicker } from "@nextui-org/react";
import Image from "next/legacy/image";
import { cities } from "./data";
import { getLocalTimeZone, today } from "@internationalized/date";

export default function Home() {
  return (
    <div className="flex flex-col bg-tertiary items-center font-serif font-bold min-h-screen">
      <header className="relative mb-12 w-full h-screen">
        <Image
          src="/salon-hero.jpg"
          alt="Salon Booking System Logo"
          layout="fill"
          objectFit="cover"
          className="absolute inset-0 z-0"
        />
        <div className="relative z-10 flex flex-col items-center justify-center h-full bg-black bg-opacity-10">
          <h1 className="sm:text-9xl font-bold mt-4 text-white">Welcome</h1>
          <p className="text-6xl mt-2 text-white">Book your appointment with ease</p>
          <div className="mt-20 flex items-center gap-4 bg-tertiary p-8 rounded-3xl">
            <Autocomplete
              defaultItems={cities}
              label="Select City"
              className="max-w-[400px] w-[300px] font-serif"
            >
              {cities.map((city) => (
                <AutocompleteItem key={city.value}>{city.label}</AutocompleteItem>
              ))}
            </Autocomplete>
            <DatePicker
              className="font-serif w-[300px] max-w-[400px]"
              label="Booking Date"
              minValue={today(getLocalTimeZone())}
              defaultValue={today(getLocalTimeZone())}
            />
            <Button color="primary" className="h-full w-48 text-xl">
              Search
            </Button>
          </div>
        </div>
      </header>

      <footer className="mt-12 text-center">
        <p className="text-sm text-gray-600">
          &copy; 2023 Salon Booking System. All rights reserved.
        </p>
      </footer>
    </div>
  );
}
