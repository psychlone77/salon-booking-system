"use client";

import { Autocomplete, AutocompleteItem, Button, DatePicker } from "@nextui-org/react";
import Image from "next/legacy/image";
import { cities } from "./data";
import { getLocalTimeZone, today } from "@internationalized/date";
import { useRouter } from "next/navigation";

export default function Home() {
  const router = useRouter();

  return (
    <div className="flex flex-col items-center font-serif font-bold min-h-screen">
      <header className="relative mb-12 w-full h-screen">
        <Image
          src="/salon-hero.jpg"
          alt="Salon Booking System Logo"
          layout="fill"
          objectFit="cover"
          className="absolute inset-0 z-0"
        />
        <div className="relative z-10 flex flex-col items-center justify-center h-full bg-black bg-opacity-10">
          <p className="sm:text-7xl text-5xl mt-2 text-white">Book local beauty and wellness services</p>
          <div className="mt-20 flex lg:flex-row flex-col items-center gap-4 bg-tertiary p-8 rounded-3xl shadow-2xl">
            <Autocomplete
              defaultItems={cities}
              label="Select City"
              className="max-w-xl font-serif"
            >
              {cities.map((city) => (
                <AutocompleteItem key={city.value}>{city.label}</AutocompleteItem>
              ))}
            </Autocomplete>
            <DatePicker
              className="font-serifmax-w-xl"
              label="Booking Date"
              minValue={today(getLocalTimeZone())}
              defaultValue={today(getLocalTimeZone())}
            />
            <Button color="primary" className="lg:h-full h-16 w-80 text-xl" onPress={() => router.push("/search")}>
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
