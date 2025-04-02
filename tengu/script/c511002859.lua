--究極竜騎士 (Anime)
--Dragon Master Knight (Anime)
--updated by ClaireStanfield
function c511002859.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,5405694,23995346)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c511002859.atkval)
	c:RegisterEffect(e1)
end
c511002859.material_setcode={0xdd,0x10cf,0xcf}
c511002859.listed_names={5405694,23995346}
function c511002859.filter(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsRace(RACE_DRAGON)
end
function c511002859.atkval(e,c)
	return Duel.GetMatchingGroupCount(c511002859.filter,c:GetControler(),LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,c)*500
end