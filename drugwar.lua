--[[
	- Created by Jonas
	- 21.03.2013
	- Copyright by Jonas
]]
local tage = 31
local standort = "Koeln"
local schulden = 5000
local guthaben = 2000
local kurs = 1
drogen = {}
drogen[1] = {
	name = "Gras (Stanni)",
	preis = 8,
}
drogen[2] = {
	name = "Gras (Haze)",
	preis = 12.5,
}
drogen[3] = {
	name = "Hasch",
	preis = 5,
}
drogen[4] = {
	name = "Heroin",
	preis = 65,
}
drogen[5] = {
	name = "Crystle Meth",
	preis = 15
}
drogen[6] = {
	name = "Pilze",
	preis = 8,
}
Inventar = {}
Anzahl = {}

reisen = function()
	os.execute( "cls" )
	hood = {}
	hood[1] = { name = "Berlin" }
	hood[2] = { name = "Muenchen" }
	hood[3] = { name = "Koeln" }
	hood[4] = { name = "Hamburg" }
	hood[5] = { name = "Essen" }
	print("")
	for b, town in pairs(hood) do
		print(b, town.name)
	end
	print("")
	print("Wohin möchtest du Reisen ?")
	ghetto = io.read()
	standort = hood[tonumber(ghetto)].name
	kurs = math.random(1, 3)
	return true
end

drogen_kaufen = function()
	os.execute( "cls" )
	print(" __, __, _,_  _, _  _  _, __, ")
	print(" | \ |_) | | / _ |  | /_\ |_) ")
	print(" |_/ | \ | | \ / |/\| | | | \ ")
	print(" ~   ~ ~ `~'  ~  ~  ~ ~ ~ ~ ~ ")
	print("")
	for a, drugs in pairs(drogen) do
		print(a, drugs.name, tostring(drugs.preis * kurs))
	end
	print("Was möchtest du kaufen ?")
	eingabe = tonumber(io.read())
	print("Wie viel Möchtest du kaufen ?")
	menge = tonumber(io.read())
	endpreis = (drogen[eingabe].preis * kurs) * menge
	if guthaben < endpreis then return print("Du hast nicht genug Geld !") end
	guthaben = guthaben - endpreis
	table.insert(Inventar, drogen[eingabe].name)
	table.insert(Anzahl, menge)
	return true
end

verkaufen = function()
	os.execute ( "cls" )
	print(" __, __, _,_  _, _  _  _, __, ")
	print(" | \ |_) | | / _ |  | /_\ |_) ")
	print(" |_/ | \ | | \ / |/\| | | | \ ")
	print(" ~   ~ ~ `~'  ~  ~  ~ ~ ~ ~ ~ ")
	print("Inventar:")
	print("Index | Drogen | Anzahl")
	for i = 1, table.getn(Inventar), 1 do
		print(i.."|"..Inventar[i].."|"..Anzahl[i])
	end
	eingabe = io.read()
	if string.len(eingabe) > 0 then
		print("Wie viel möchtest du Verkaufen ?")
		menge = io.read()
		if string.len(menge) > 0 then
			name = Inventar[tonumber(eingabe)]
			preis = 0
			for i, b in pairs(drogen) do
				if b.name == Inventar[eingabe] then
					preis = b.preis * menge
				end
			end
			guthaben = guthaben + preis
			table.remove(Inventar, eingabe)
			table.remove(Anzahl, eingabe)
		end
	end
	return true
end

schulden_bezahlen = function()
	os.execute( "cls" )
	print(" __, __, _,_  _, _  _  _, __, ")
	print(" | \ |_) | | / _ |  | /_\ |_) ")
	print(" |_/ | \ | | \ / |/\| | | | \ ")
	print(" ~   ~ ~ `~'  ~  ~  ~ ~ ~ ~ ~ ")
	print("Schulden: "..schulden)
	print("Dein Bar-Geld:" ..guthaben)
	print("Wie viel möchtest du bezahlen?")
	geld = 0
	while (geld < 1) do
		test = io.read()
		if tonumber(test) > 0 then
			if tonumber(test) > guthaben then 
				print("Du kannst nicht mehr bezahlen als du selber besitzt")
			else
				geld = tonumber(test)
			end
		end
	end
	schulden = schulden - tonumber(geld)
	guthaben = guthaben - tonumber(geld)
	return true
end

print("Willkommen bei Dopewars")
for i = 1, tage, 1 do
	os.execute( "cls" )
	if tage == 30 then
		return print("Dein Spiel ist zuende. :D")
	end
	print(" __, __, _,_  _, _  _  _, __, ")
	print(" | \ |_) | | / _ |  | /_\ |_) ")
	print(" |_/ | \ | | \ / |/\| | | | \ ")
	print(" ~   ~ ~ `~'  ~  ~  ~ ~ ~ ~ ~ ")
	print(" Standort: "..standort)
	print(" Schulden: "..schulden)
	print(" Geld: "..guthaben)
	print(" Tag: "..i)
	print("")
	print(" | Inventar |   ")
	for i = 1, table.getn(Inventar), 1 do
		print(Inventar[i].."|"..Anzahl[i])
	end
	print("")
	print("Was möchtest du tun ?")
	print("1. Reisen")
	print("2. Schulden Bezahlen")
	print("3. Einkaufen")
	print("4. Verkaufen")
	print("5. Beenden")
	select = io.read()
	if tonumber(select) == 1 then
		if reisen() == true then
			print("Du bist nun in ein anderes Ghetto gefahren")
		end
	elseif tonumber(select) == 2 then
		if schulden_bezahlen() == true then
			print("Du hast deine Schulden erfolgreich beglichen")
		end
	elseif tonumber(select) == 3 then
		if drogen_kaufen() == true then
			print("Du hast erfolgreich Drogen gekauft")
		end
	elseif tonumber(select) == 4 then
		if verkaufen() == true then
			print("Du hast erfolgreich Drogen verkauft")
		end
	elseif tonumber(select) == 5 then
		os.execute("exit")
	else
		print("Unbekannte Eingabe !")
		i = i + 1
	end
end

