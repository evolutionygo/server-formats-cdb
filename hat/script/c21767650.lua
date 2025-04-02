--水精鱗－アビスマンダー
--Mermail Abyssmander
function c21767650.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc21767650(c21767650,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c21767650.lvtg)
	e1:SetOperation(c21767650.lvop)
	c:RegisterEffect(e1)
end
c21767650.listed_series={0x74}
function c21767650.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x74) and c:HasLevel()
end
function c21767650.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21767650.filter,tp,LOCATION_MZONE,0,1,nil) end
	local opt=Duel.SelectOption(tp,aux.Stringc21767650(c21767650,1),aux.Stringc21767650(c21767650,2))
	e:SetLabel(opt)
end
function c21767650.lvop(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local g=Duel.GetMatchingGroup(c21767650.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(opt+1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end