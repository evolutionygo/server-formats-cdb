--アルカナフォースⅣ－THE EMPEROR
--Arcana Force IV - The Emperor
function c61175706.initial_effect(c)
	--Toss a coin and apply the appropriate effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc61175706(c61175706,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c61175706.cointg)
	e1:SetOperation(c61175706.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
c61175706.listed_series={SET_ARCANA_FORCE}
c61175706.toss_coin=true
function c61175706.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c61175706.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	c61175706.arcanareg(c,Arcana.TossCoin(c,tp))
end
function c61175706.arcanareg(c,coin)
	--coin effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,SET_ARCANA_FORCE))
	e1:SetValue(c61175706.atkval)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD)
	c:RegisterEffect(e1)
	--
	Arcana.RegisterCoinResult(c,coin)
end
function c61175706.atkval(e,c)
	local coin=Arcana.GetCoinResult(e:GetHandler())
	if coin==COIN_HEADS then
		return 500
	elseif coin==COIN_TAILS then
		return -500
	else
		return 0
	end
end