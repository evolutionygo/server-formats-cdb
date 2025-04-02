--ブルーサンダーＴ４５
--Blue Thunder T-45
function c14089428.initial_effect(c)
	--Special summon 1 token to your field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc14089428(c14089428,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdocon)
	e1:SetTarget(c14089428.target)
	e1:SetOperation(c14089428.operation)
	c:RegisterEffect(e1)
end
c14089428.listed_names={14089429}
function c14089428.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c14089428.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c14089428+1,0,TYPES_TOKEN,1500,1500,4,RACE_MACHINE,ATTRIBUTE_LIGHT) then
		local token=Duel.CreateToken(tp,c14089428+1)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		--Cannot be tributed for a tribute summon
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(3304)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		token:RegisterEffect(e1)
	end
end