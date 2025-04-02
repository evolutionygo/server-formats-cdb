--オルターガイスト・プークエリ (Anime)
--Altergeist Pookuery (Anime)
local s,c511009952,alias=GetID()
function c511009952.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Extra Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_EXTRA_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCountLimit(1,alias)
	e1:SetOperation(c511009952.extracon)
	e1:SetValue(c511009952.extraval)
	c:RegisterEffect(e1)
	if c511009952.flagmap==nil then
		c511009952.flagmap={}
	end
	if c511009952.flagmap[c]==nil then
		c511009952.flagmap[c] = {}
	end
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511009952(alias,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,{alias,1})
	e2:SetCondition(c511009952.thcon)
	e2:SetTarget(c511009952.thtg)
	e2:SetOperation(c511009952.thop)
	c:RegisterEffect(e2)
end
c511009952.listed_series={0x103}
function c511009952.extrafilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c511009952.extracon(c,e,tp,sg,mg,lc,og,chk)
	return (sg+mg):Filter(c511009952.extrafilter,nil,e:GetHandlerPlayer()):IsExists(Card.IsSetCard,1,og,0x103) and
	sg:FilterCount(c511009952.flagcheck,nil)<2
end
function c511009952.flagcheck(c)
	return c:GetFlagEffect(c511009952)>0
end
function c511009952.extraval(chk,summon_type,e,...)
	local c=e:GetHandler()
	if chk==0 then
		local tp,sc=...
		if summon_type~=SUMMON_TYPE_LINK or not sc:IsSetCard(0x103) or Duel.GetFlagEffect(tp,c511009952)>0 then
			return Group.CreateGroup()
		else
			table.insert(c511009952.flagmap[c],c:RegisterFlagEffect(c511009952,0,0,1))
			return Group.FromCards(c)
		end
	elseif chk==1 then
		local sg,sc,tp=...
		if summon_type&SUMMON_TYPE_LINK == SUMMON_TYPE_LINK and #sg>0 then
			Duel.Hint(HINT_CARD,tp,c511009952)
			Duel.RegisterFlagEffect(tp,c511009952,RESET_PHASE+PHASE_END,0,1)
		end
	elseif chk==2 then
		for _,eff in ipairs(c511009952.flagmap[c]) do
			eff:Reset()
		end
		c511009952.flagmap[c]={}
	end
end
function c511009952.cfilter(c,tp)
	return c:IsSetCard(0x103) and c:IsLinkMonster() and c:IsControler(tp) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c511009952.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009952.cfilter,1,nil,tp)
end
function c511009952.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c511009952.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end