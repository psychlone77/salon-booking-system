import Image from "next/image";
import React from "react";

interface Salon {
  id: number;
  name: string;
  address: string;
  rating: number;
}

interface SearchResultsProps {
  salons: Salon[];
}

const SearchResults: React.FC<SearchResultsProps> = ({ salons }) => {
  return (
    <div className="flex flex-col gap-6 overflow-y-scroll w-full" style={{ maxHeight: "calc(100vh - 300px)" }}>
      {salons.map((salon) => (
        <div key={salon.id} className="salon-card w-full rounded-xl bg-accent p-5 shadow-md">
          <Image
            src="/salon-inside.jpg"
            alt="Salon Booking System Logo"
            className="rounded-xl"
            objectFit="cover"
            width={500}
            height={300}
          />
          <h2 className="font-bold text-xl">{salon.name}</h2>
          <p>{salon.address}</p>
          <p>Rating: {salon.rating}</p>
        </div>
      ))}
    </div>
  );
};

export default SearchResults;
