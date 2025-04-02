--きまぐれの女神
--Goddess of Whim
function c67959180.initial_effect(c)
	--Toss a coin and either double or halve ATK
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc67959180(c67959180,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c67959180.target)
	e1:SetOperation(c67959180.operation)
	c:RegisterEffect(e1)
end
c67959180.toss_coin=true
function c67959180.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c67959180.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE|RESET_PHASE|PHASE_END)
		if Duel.CallCoin(tp) then
			e1:SetValue(c:GetAttack()*2)
		else
			e1:SetValue(c:GetAttack()/2)
		end
		c:RegisterEffect(e1)
	end
end