--オヤコーン (Manga)
--Papa-Corn (Manga)
--original script by Shad3
function c511005008.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetValue(c511005008.val)
	c:RegisterEffect(e1)
end
c511005008.listed_names={511002672}
function c511005008.val(e,c)
	if Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,511002672),0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
		return 1000
	end
	return 0
end