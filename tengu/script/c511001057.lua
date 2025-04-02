--パーフェクト機械王 (Anime)
--Perfect Machine King (Anime)
function c511001057.initial_effect(c)
	--Fusion Materials
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,44203504,46700124)
	--Gains 500 ATK for each Machine monster on the field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511001057.val)
	c:RegisterEffect(e1)
end
c511001057.listed_names={44203504,46700124}
function c511001057.val(e,c)
	return Duel.GetMatchingGroupCount(aux.FaceupFilter(Card.IsRace,RACE_MACHINE),c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*500
end