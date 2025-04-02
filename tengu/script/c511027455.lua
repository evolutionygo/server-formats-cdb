--エッジインプ・ＤＴモドキ (Anime)
--Edge Imp Frightfuloc511027455 (Anime)
--Scripted By Sever666
function c511027455.initial_effect(c)
	--code
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetValue(0xad)
	c:RegisterEffect(e1)
end
c511027455.listed_series={0xad}